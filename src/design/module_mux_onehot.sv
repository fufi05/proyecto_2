module module_mux_onehot (
    input [1:0] sel,
    output reg [3:0] out2
);
    always_comb begin
        case(sel)
            2'b00: out2 = 4'b0001;
            2'b01: out2 = 4'b0010;
            2'b10: out2 = 4'b0100;
            2'b11: out2 = 4'b1000;
        default: out2 = '0;
        endcase
    end
endmodule