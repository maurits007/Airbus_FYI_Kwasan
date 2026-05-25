module ro (input enable, output ro_clk);

    (*dont_touch="true"*) logic [8:0] inv;

    // 1 NAND
    LUT2 #(
      .INIT(4'h7)
    ) LUT2_inst (
        .O(inv[0]),
        .I0(inv[8]),
        .I1(enable)
    );

    // 9 NOT
    LUT1 #(
      .INIT(2'b01)
    ) LUT1_inst0 (
      .O(inv[1]),
      .I0(inv[0])
    );

    LUT1 #(
      .INIT(2'b01)
    ) LUT1_inst1 (
      .O(inv[2]),
      .I0(inv[1])
    );

    LUT1 #(
      .INIT(2'b01)
    ) LUT1_inst2 (
      .O(inv[3]),
      .I0(inv[2])
    );

    LUT1 #(
      .INIT(2'b01)
    ) LUT1_inst3 (
      .O(inv[4]),
      .I0(inv[3])
    );

    LUT1 #(
      .INIT(2'b01)
    ) LUT1_inst4 (
      .O(inv[5]),
      .I0(inv[4])
    );

    LUT1 #(
      .INIT(2'b01)
    ) LUT1_inst5 (
      .O(inv[6]),
      .I0(inv[5])
    );

    LUT1 #(
      .INIT(2'b01)
    ) LUT1_inst6 (
      .O(inv[7]),
      .I0(inv[6])
    );

    LUT1 #(
      .INIT(2'b01)
    ) LUT1_inst7 (
      .O(inv[8]),
      .I0(inv[7])
    );

    // Out
    assign ro_clk = inv[8];

endmodule