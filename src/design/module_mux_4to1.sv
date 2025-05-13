module module_mux_4to1 (
    input [3:0] unidades,                 
    input [3:0] decenas,                 
    input [3:0] centenas,                 
    input [3:0] millares,                 
    input [3:0] sel,               
    output reg [3:0] out
);
    always_comb begin
        case(sel)
            4'b0001 : out = unidades;
            4'b0010 : out = decenas;
            4'b0100 : out = centenas;
            4'b1000 : out = millares;
        default: out = '0;
        endcase
    end
endmodule