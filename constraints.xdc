# set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports {rst_n}]
# set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports {en}]

# LEDs
# set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports {counter_out[0]}]
# set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {counter_out[1]}]
# set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {counter_out[2]}]
# set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {counter_out[3]}]

# Switches for challenge
# set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports {challenge[0]}]
# set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33} [get_ports {challenge[1]}]

set_property -dict {PACKAGE_PIN AK17 IOSTANDARD LVDS} [get_ports {clk_p}]
create_clock -add -name sys_clk_pin -period 3.33 [get_ports {clk_p}]

set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets -of_objects [get_cells ro_inst_0]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets -of_objects [get_cells ro_inst_1]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets -of_objects [get_cells ro_inst_2]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets -of_objects [get_cells ro_inst_3]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets -of_objects [get_cells ro_inst_4]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets -of_objects [get_cells ro_inst_5]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets -of_objects [get_cells ro_inst_6]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets -of_objects [get_cells ro_inst_7]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets ro_inst_0/inv[1]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets ro_inst_1/inv[1]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets ro_inst_2/inv[1]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets ro_inst_3/inv[1]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets ro_inst_4/inv[1]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets ro_inst_5/inv[1]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets ro_inst_6/inv[1]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets ro_inst_7/inv[1]]
# Sets the exact placement of ro_inst_0/LUT2_inst.
set_property LOC SLICE_X7Y35 [get_cells ro_inst_0/LUT2_inst]

# Sets the placement of all ro's relative to ro_inst_0/LUT2_inst.
create_macro ro_placer_macro
update_macro [get_macros ro_placer_macro] -rlocs {
    ro_inst_0/LUT2_inst X0Y0
    ro_inst_0/LUT1_inst0 X0Y0
    ro_inst_0/LUT1_inst1 X0Y1
    ro_inst_0/LUT1_inst2 X0Y2
    ro_inst_0/LUT1_inst3 X0Y3
    ro_inst_0/LUT1_inst4 X0Y4
    ro_inst_0/LUT1_inst5 X0Y5
    ro_inst_0/LUT1_inst6 X0Y6
    ro_inst_0/LUT1_inst7 X0Y7

    ro_inst_1/LUT2_inst X1Y0
    ro_inst_1/LUT1_inst0 X1Y0
    ro_inst_1/LUT1_inst1 X1Y1
    ro_inst_1/LUT1_inst2 X1Y2
    ro_inst_1/LUT1_inst3 X1Y3
    ro_inst_1/LUT1_inst4 X1Y4
    ro_inst_1/LUT1_inst5 X1Y5
    ro_inst_1/LUT1_inst6 X1Y6
    ro_inst_1/LUT1_inst7 X1Y7

    ro_inst_2/LUT2_inst X2Y0
    ro_inst_2/LUT1_inst0 X2Y0
    ro_inst_2/LUT1_inst1 X2Y1
    ro_inst_2/LUT1_inst2 X2Y2
    ro_inst_2/LUT1_inst3 X2Y3
    ro_inst_2/LUT1_inst4 X2Y4
    ro_inst_2/LUT1_inst5 X2Y5
    ro_inst_2/LUT1_inst6 X2Y6
    ro_inst_2/LUT1_inst7 X2Y7

    ro_inst_3/LUT2_inst X3Y0
    ro_inst_3/LUT1_inst0 X3Y0
    ro_inst_3/LUT1_inst1 X3Y1
    ro_inst_3/LUT1_inst2 X3Y2
    ro_inst_3/LUT1_inst3 X3Y3
    ro_inst_3/LUT1_inst4 X3Y4
    ro_inst_3/LUT1_inst5 X3Y5
    ro_inst_3/LUT1_inst6 X3Y6
    ro_inst_3/LUT1_inst7 X3Y7

    ro_inst_4/LUT2_inst X4Y0
    ro_inst_4/LUT1_inst0 X4Y0
    ro_inst_4/LUT1_inst1 X4Y1
    ro_inst_4/LUT1_inst2 X4Y2
    ro_inst_4/LUT1_inst3 X4Y3
    ro_inst_4/LUT1_inst4 X4Y4
    ro_inst_4/LUT1_inst5 X4Y5
    ro_inst_4/LUT1_inst6 X4Y6
    ro_inst_4/LUT1_inst7 X4Y7

    ro_inst_5/LUT2_inst X5Y0
    ro_inst_5/LUT1_inst0 X5Y0
    ro_inst_5/LUT1_inst1 X5Y1
    ro_inst_5/LUT1_inst2 X5Y2
    ro_inst_5/LUT1_inst3 X5Y3
    ro_inst_5/LUT1_inst4 X5Y4
    ro_inst_5/LUT1_inst5 X5Y5
    ro_inst_5/LUT1_inst6 X5Y6
    ro_inst_5/LUT1_inst7 X5Y7

    ro_inst_6/LUT2_inst X6Y0
    ro_inst_6/LUT1_inst0 X6Y0
    ro_inst_6/LUT1_inst1 X6Y1
    ro_inst_6/LUT1_inst2 X6Y2
    ro_inst_6/LUT1_inst3 X6Y3
    ro_inst_6/LUT1_inst4 X6Y4
    ro_inst_6/LUT1_inst5 X6Y5
    ro_inst_6/LUT1_inst6 X6Y6
    ro_inst_6/LUT1_inst7 X6Y7

    ro_inst_7/LUT2_inst X7Y0
    ro_inst_7/LUT1_inst0 X7Y0
    ro_inst_7/LUT1_inst1 X7Y1
    ro_inst_7/LUT1_inst2 X7Y2
    ro_inst_7/LUT1_inst3 X7Y3
    ro_inst_7/LUT1_inst4 X7Y4
    ro_inst_7/LUT1_inst5 X7Y5
    ro_inst_7/LUT1_inst6 X7Y6
    ro_inst_7/LUT1_inst7 X7Y7
}
