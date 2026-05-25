module counter(input clk, input rst_n, output [31:0] count);

    logic [31:0] value;

    always_ff @( posedge clk ) begin
        if (!rst_n) value <= 32'b0;
        else value <= value + 1'b1;
    end

    assign count = value;

endmodule