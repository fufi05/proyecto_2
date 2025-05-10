module module_deco2a4 (
    input  logic [1:0] in,       // Entrada de 2 bits (desde el contador)
    output logic [3:0] out       // Salida de 4 bits (one-hot)
);

    always_comb begin
        case (in)
            2'b00: out = 4'b0001;
            2'b01: out = 4'b0010;
            2'b10: out = 4'b0100;
            2'b11: out = 4'b1000;
            default: out = 4'b0000; // Por seguridad
        endcase
    end
endmodule
