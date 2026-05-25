# Ring Oscillator PUF — FPGA Implementation

## Overview

This project implements a **Ring Oscillator Physical Unclonable Function (RO-PUF)** on a Xilinx FPGA. A PUF exploits tiny, unavoidable manufacturing variations between chips to generate a unique device fingerprint: the same challenge (input) will produce the same response on a given chip, but a different response on every other chip. This makes PUFs useful for device authentication and key generation without needing to store secrets in non-volatile memory.

---

## How It Works — Step by Step

### 1. Ring Oscillators (`ro.sv`)

A **ring oscillator** is a chain of an odd number of inverting gates with its output fed back to its input. Because the total inversion count is odd, the circuit has no stable state and oscillates continuously. The oscillation frequency depends on the propagation delay of each gate — and those delays vary slightly from chip to chip due to manufacturing process variation.

This design uses **8 ring oscillators** (`ro_inst_0` through `ro_inst_7`), each built from:
- 1 × **NAND gate** (LUT2, `INIT=4'h7`) — acts as an enable-controlled inverter. When `enable=0`, the feedback is broken and the RO stops. When `enable=1`, it oscillates.
- 8 × **NOT gates** (LUT1, `INIT=2'b01`) — completing the odd-length inverter chain (9 inverting stages total).

All gates carry the `(*dont_touch="true"*)` attribute to prevent Vivado from optimising them away or merging them, which would destroy the physical variation they are meant to capture.

```
enable ──┐
         └► [NAND] ──► [NOT]×8 ──► ro_clk
                 ▲                      │
                 └──────────────────────┘
```

### 2. MUX-Based RO Pairing (`mux.sv`, used in `top.sv`)

A key security concern with RO-PUFs is that an attacker who can observe individual RO frequencies might model the PUF and predict responses. This design uses a **challenge-controlled crossbar** to make that harder.

Each `mux` module is a simple **4-to-1 multiplexer**: a 2-bit `select` input picks one of four signals to pass through. In `top.sv`, 16 mux instances are arranged so that a 4-bit `challenge` input determines *which* ROs are paired together for comparison, rather than always comparing the same fixed pairs.

- `mux_inst_0` through `mux_inst_7` are driven by `challenge[1:0]` and draw from ROs 0–3.
- `mux_inst_8` through `mux_inst_15` are driven by `challenge[3:2]` and draw from ROs 4–7.

Each mux presents a different shuffled ordering of the RO clocks depending on the challenge bits, so the same physical ROs produce different pairings for different challenges. This multiplies the number of challenge–response pairs (CRPs) the PUF can produce.

### 3. Counters (`counter.sv`, used in `top.sv`)

Each mux output drives a dedicated **32-bit free-running counter** (`mux_counter_0` through `mux_counter_15`). All counters are reset simultaneously via `rst_n`. While the ROs are enabled, each counter increments on every rising edge of its assigned mux output clock — so after a fixed measurement window, the counter value is proportional to that RO's oscillation frequency.

### 4. Response Generation (`top.sv`)

After the measurement window, the 16 counters are compared in 8 pairs:

```
ro_compared[0] = (mux_cnt_0 > mux_cnt_8)  ? 1 : 0
ro_compared[1] = (mux_cnt_1 > mux_cnt_9)  ? 1 : 0
...
ro_compared[7] = (mux_cnt_7 > mux_cnt_15) ? 1 : 0
```

Each comparison produces **one response bit**: `1` if the first counter ran faster, `0` if the second ran faster. Together, the 8 comparison bits form the 8-bit **PUF response** (`ro_compared`). Because the relative speeds of the ROs are determined by manufacturing variation, this response is stable and chip-unique.

### 5. Sampler (`sampler.sv`)

The `sampler` module controls the measurement window and latches the result. It counts **1024 system clock cycles** (configurable via parameter `MAX`), then:
1. Samples the current value of `ro_compared` into an internal register.
2. Raises `done` to signal that the measurement is complete and freeze the result.
3. Disables the ring oscillators (via `en_ro = !done & en` in `top.sv`) to save power.

The sampled value is held stable on `out` until the system is reset.

### 6. Placement Constraints (`constraints.xdc`)

For a PUF to be reliable, it is critical that the ring oscillators are placed consistently and close together so that they experience the same environmental conditions (temperature, supply voltage). The constraints file:

- **Anchors `ro_inst_0/LUT2_inst` to a specific FPGA slice** (`SLICE_X7Y35`).
- **Places all 8 ROs in a compact macro** using relative coordinates, so each RO occupies its own column of LUT slices, all within the same local region of the fabric.
- **Allows combinatorial loops** on each RO's nets — Xilinx tools normally flag these as errors, so they must be explicitly permitted.
- Sets the **system clock** to the differential input pair `clk_p`/`clk_n` at 300 MHz (3.33 ns period) via an `IBUFDS` buffer.

### 7. VIO Integration (`top.sv`)

The top module uses a **Vivado VIO (Virtual I/O) core** (`vio_0`) to allow real-time interaction over JTAG without physical switches or LEDs:

| VIO Signal | Direction | Purpose |
|---|---|---|
| `probe_in0` | Input to VIO | Displays the 8-bit sampled PUF response |
| `probe_out0` | Output from VIO | Drives the 4-bit `challenge` input |
| `probe_out1` | Output from VIO | Enables the ROs (`en`) |
| `probe_out2` | Output from VIO | Active-low reset (`rst_n`) |

---

## File Summary

| File | Description |
|---|---|
| `ro.sv` | Ring oscillator primitive: 1 NAND + 8 NOT gates, enable-controlled |
| `mux.sv` | 4-to-1 multiplexer used to route RO clocks under challenge control |
| `counter.sv` | 32-bit synchronous counter, clocked by a mux output |
| `sampler.sv` | Measurement window controller; latches response after `MAX` cycles |
| `top.sv` | Top-level: instantiates 8 ROs, 16 muxes, 16 counters, comparators, sampler, VIO |
| `constraints.xdc` | Vivado constraints: clock definition, RO placement macro, combinatorial loop exceptions |

---

## Signal Flow Diagram

```
challenge[3:0]
      │
      ├──[challenge[1:0]]──► mux_inst_0..7  ◄── RO 0..3 (ro_inst_0..3)
      │                            │
      └──[challenge[3:2]]──► mux_inst_8..15 ◄── RO 4..7 (ro_inst_4..7)
                                   │
                       mux_counter_0..15 (32-bit counters)
                                   │
                       8× comparator (cnt_N > cnt_N+8)
                                   │
                            ro_compared[7:0]
                                   │
                              sampler (1024 clk cycles)
                                   │
                          sampled_count[7:0] ──► VIO probe_in0
```

---

## Operating Procedure

1. **Program** the bitstream onto the target FPGA.
2. Open the **VIO dashboard** in Vivado Hardware Manager.
3. Assert **`rst_n = 0`** briefly to reset all counters and state, then release (`rst_n = 1`).
4. Set the desired **`challenge[3:0]`** value (0–15).
5. Assert **`en = 1`** to start the ring oscillators and the sampler.
6. After ~1024 system clock cycles, **`done`** goes high and the ROs stop automatically.
7. Read the **8-bit response** from `probe_in0` in the VIO.
8. To take a new measurement: assert `rst_n = 0` to clear `done`, release, then repeat from step 4.

---

## Design Notes

- **Why 9 stages?** Ring oscillators require an odd number of inverting stages to oscillate. More stages lower the frequency (easier to count), while fewer stages increase sensitivity to process variation. 9 is a common compromise.
- **Why `(*dont_touch="true"*)`?** Vivado's optimiser would normally merge or remove redundant logic. This attribute forces each gate to be physically placed as an independent LUT.
- **Why relative placement?** RO frequency differences are on the order of 0.1–1%. Placing ROs far apart introduces systematic spatial gradients (temperature, voltage) that can dominate over manufacturing variation, reducing PUF quality.
- **Why 1024 clock cycles?** The measurement window trades off speed against resolution. Longer windows give the counters more time to accumulate counts, making the comparison more reliable when two ROs have very similar frequencies.