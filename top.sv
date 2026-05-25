module top(input logic clk_p, input logic clk_n);
    
    logic done;
    logic en_ro;
    assign en_ro = !done & en;

    logic ro_0_clock, ro_1_clock, ro_2_clock, ro_3_clock, ro_4_clock, ro_5_clock, ro_6_clock, ro_7_clock;

    logic mux_clk_0, mux_clk_1, mux_clk_2, mux_clk_3, mux_clk_4, mux_clk_5, mux_clk_6, mux_clk_7, mux_clk_8, mux_clk_9, mux_clk_10, mux_clk_11, mux_clk_12, mux_clk_13, mux_clk_14, mux_clk_15;
    logic [31:0] mux_cnt_0, mux_cnt_1, mux_cnt_2, mux_cnt_3, mux_cnt_4, mux_cnt_5, mux_cnt_6, mux_cnt_7, mux_cnt_8, mux_cnt_9, mux_cnt_10, mux_cnt_11, mux_cnt_12, mux_cnt_13, mux_cnt_14, mux_cnt_15;
    logic clk;
    logic [7:0] ro_compared;
    logic [7:0] sampled_count;
    
    IBUFDS ibufds_inst (
        .O(clk),
        .I(clk_p),
        .IB(clk_n)
    );
    (*dont_touch="true"*) ro ro_inst_0(en_ro, ro_0_clock);
    (*dont_touch="true"*) ro ro_inst_1(en_ro, ro_1_clock);
    (*dont_touch="true"*) ro ro_inst_2(en_ro, ro_2_clock);
    (*dont_touch="true"*) ro ro_inst_3(en_ro, ro_3_clock);
    (*dont_touch="true"*) ro ro_inst_4(en_ro, ro_4_clock);
    (*dont_touch="true"*) ro ro_inst_5(en_ro, ro_5_clock);
    (*dont_touch="true"*) ro ro_inst_6(en_ro, ro_6_clock);
    (*dont_touch="true"*) ro ro_inst_7(en_ro, ro_7_clock);


    mux mux_inst_0 (challenge[1:0], {ro_3_clock, ro_2_clock, ro_1_clock, ro_0_clock}, mux_clk_0);
    mux mux_inst_1 (challenge[1:0], {ro_2_clock, ro_3_clock, ro_0_clock, ro_1_clock}, mux_clk_1);
    mux mux_inst_2 (challenge[1:0], {ro_1_clock, ro_0_clock, ro_3_clock, ro_2_clock}, mux_clk_2);
    mux mux_inst_3 (challenge[1:0], {ro_0_clock, ro_1_clock, ro_2_clock, ro_3_clock}, mux_clk_3);
    mux mux_inst_4 (challenge[1:0], {ro_3_clock, ro_1_clock, ro_0_clock, ro_2_clock}, mux_clk_4);
    mux mux_inst_5 (challenge[1:0], {ro_2_clock, ro_0_clock, ro_1_clock, ro_3_clock}, mux_clk_5);
    mux mux_inst_6 (challenge[1:0], {ro_1_clock, ro_3_clock, ro_2_clock, ro_0_clock}, mux_clk_6);
    mux mux_inst_7 (challenge[1:0], {ro_0_clock, ro_2_clock, ro_3_clock, ro_1_clock}, mux_clk_7);

    mux mux_inst_8 (challenge[3:2], {ro_7_clock, ro_6_clock, ro_5_clock, ro_4_clock}, mux_clk_8);
    mux mux_inst_9 (challenge[3:2], {ro_6_clock, ro_7_clock, ro_4_clock, ro_5_clock}, mux_clk_9);
    mux mux_inst_10(challenge[3:2], {ro_5_clock, ro_4_clock, ro_7_clock, ro_6_clock}, mux_clk_10);
    mux mux_inst_11(challenge[3:2], {ro_4_clock, ro_5_clock, ro_6_clock, ro_7_clock}, mux_clk_11);
    mux mux_inst_12(challenge[3:2], {ro_7_clock, ro_5_clock, ro_4_clock, ro_6_clock}, mux_clk_12);
    mux mux_inst_13(challenge[3:2], {ro_6_clock, ro_4_clock, ro_5_clock, ro_7_clock}, mux_clk_13);
    mux mux_inst_14(challenge[3:2], {ro_5_clock, ro_7_clock, ro_6_clock, ro_4_clock}, mux_clk_14);
    mux mux_inst_15(challenge[3:2], {ro_4_clock, ro_6_clock, ro_7_clock, ro_5_clock}, mux_clk_15);

    counter mux_counter_0(mux_clk_0, rst_n, mux_cnt_0);
    counter mux_counter_1(mux_clk_1, rst_n, mux_cnt_1);
    counter mux_counter_2(mux_clk_2, rst_n, mux_cnt_2);
    counter mux_counter_3(mux_clk_3, rst_n, mux_cnt_3);
    counter mux_counter_4(mux_clk_4, rst_n, mux_cnt_4);
    counter mux_counter_5(mux_clk_5, rst_n, mux_cnt_5);
    counter mux_counter_6(mux_clk_6, rst_n, mux_cnt_6);
    counter mux_counter_7(mux_clk_7, rst_n, mux_cnt_7);
    counter mux_counter_8(mux_clk_8, rst_n, mux_cnt_8);
    counter mux_counter_9(mux_clk_9, rst_n, mux_cnt_9);
    counter mux_counter_10(mux_clk_10, rst_n, mux_cnt_10);
    counter mux_counter_11(mux_clk_11, rst_n, mux_cnt_11);
    counter mux_counter_12(mux_clk_12, rst_n, mux_cnt_12);
    counter mux_counter_13(mux_clk_13, rst_n, mux_cnt_13);
    counter mux_counter_14(mux_clk_14, rst_n, mux_cnt_14);
    counter mux_counter_15(mux_clk_15, rst_n, mux_cnt_15);

    assign ro_compared[0] = (mux_cnt_0 > mux_cnt_8) ? 1'b1 : 1'b0;
    assign ro_compared[1] = (mux_cnt_1 > mux_cnt_9) ? 1'b1 : 1'b0;
    assign ro_compared[2] = (mux_cnt_2 > mux_cnt_10) ? 1'b1 : 1'b0;
    assign ro_compared[3] = (mux_cnt_3 > mux_cnt_11) ? 1'b1 : 1'b0;
    assign ro_compared[4] = (mux_cnt_4 > mux_cnt_12) ? 1'b1 : 1'b0;
    assign ro_compared[5] = (mux_cnt_5 > mux_cnt_13) ? 1'b1 : 1'b0;
    assign ro_compared[6] = (mux_cnt_6 > mux_cnt_14) ? 1'b1 : 1'b0;
    assign ro_compared[7] = (mux_cnt_7 > mux_cnt_15) ? 1'b1 : 1'b0;

    sampler sampler(clk, rst_n, ro_compared, done, sampled_count);

    assign counter_out = sampled_count;

    vio_0 vio_inst (
        .clk(clk),
        .probe_in0(counter_out),
        .probe_out0(challenge),
        .probe_out1(en),
        .probe_out2(rst_n)
    );
endmodule
