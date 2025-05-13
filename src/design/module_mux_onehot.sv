module mux_onehot (
    a = 4'b0001;
    b = 4'b0010;
    c = 4'b0100;
    d = 4'b1000;
    input [1:0] sel,
    output reg [3:0] out2;
);
    always_comb @(sel)begin :
        out2 = '0;
        case(sel)
            2'b00 : out <= a;
            2'b01 : out <= b;
            2'b10 : out <= c;
            2'b11 : out <= d;
        endcase
        default: out2 = '0;
    end
endmodule