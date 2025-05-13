module module_mux_4to1 (
    input [3:0] unidades,                 
    input [3:0] decenas,                 
    input [3:0] centenas,                 
    input [3:0] millares,                 
    input [1:0] sel,               
    output reg [3:0] out
);
    always_comb begin
        case(sel)
            2'b00 : out = unidades;
            2'b01 : out = decenas;
            2'b10 : out = centenas;
            2'b11 : out = millares;
        default: out = '0;
        endcase
    end
endmodule