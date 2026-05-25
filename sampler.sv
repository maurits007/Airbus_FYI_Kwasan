module sampler #(parameter int MAX = 1024)(
    input logic clk, 
    input logic rst_n,
    input logic [7:0] ro_counter,
    output logic done,
    output logic [7:0] out
);

    logic [10:0] counter;
    logic [7:0] sampled;

    always_ff @( posedge clk ) begin
        if (!rst_n) begin
            done <= 1'b0;
            sampled <= 8'b0;
            counter <= 11'b0;
        end else begin
            if (counter == MAX && !done) begin
                sampled <= ro_counter;
                counter <= 11'b0;
                done <= 1'b1;
            end else counter <= counter + 1'b1;
        end        
    end

    assign out = sampled;

endmodule
