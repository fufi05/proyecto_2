module mux_4to1 (
    input [6:0] unidades,                 
    input [6:0] decenas,                 
    input [6:0] centenas,                 
    input [6:0] millares,                 
    input [1:0] sel,               
    output reg [6:0] out
);
    always_comb @(sel) begin
        out = '0;
        case(sel)
            2'b00 : out <= a;
            2'b01 : out <= b;
            2'b10 : out <= c;
            2'b11 : out <= d;
        endcase
        default: out = '0;
    end
endmodule