module mux(input logic [1:0] select, input logic [3:0] in, output logic out);

    always_comb begin
        unique case (select)
            2'b00: out = in[0];    
            2'b01: out = in[1];
            2'b10: out = in[2];
            2'b11: out = in[3];
        endcase
    end

endmodule