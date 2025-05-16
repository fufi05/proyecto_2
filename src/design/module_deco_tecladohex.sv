/* Decode the asserted fila and col
                                    col[0] col[1] col[2] col[3]
        fila[0]                      1       2       3       A
        fila[1]                      4       5       6       B
        fila[2]                      7       8       9       C
        fila[3]                      *       0       #       D           */

module module_deco_tecladohex (
    input  logic [3:0] fila,      // one-hot, activo en alto
    input  logic [3:0] col,      // one-hot, activo en alto
    output logic [3:0] num // número en binario natural
);
logic [7:0] d;
assign d = {fila, col}; // concatenación de fila y columna
    always_comb begin
        num = 4'b0000; // valor por defecto
        case (d)
            8'b0001_0001: num = 4'b0001;     // 1-fila[0], col[0]
            8'b0001_0010: num = 4'b0010;    // 2
            8'b0001_0100: num = 4'b0011;   // 3
            8'b0001_1000: num = 4'b0000;  // A

            8'b0010_0001: num = 4'b0100;     // 4-fila[1], col[0]
            8'b0010_0010: num = 4'b0101;    // 5
            8'b0010_0100: num = 4'b0110;   // 6
            8'b0010_1000: num = 4'b0000;  // B

            8'b0100_0001: num = 4'b0111;     // 7-fila[2], col[0]
            8'b0100_0010: num = 4'b1000;    // 8
            8'b0100_0100: num = 4'b1001;   // 9
            8'b0100_1000: num = 4'b0000;  // C

            8'b1000_0001: num = 4'b1110;     // * - fila[3], col[0]
            8'b1000_0010: num = 4'b0000;    // 0
            8'b1000_0100: num = 4'b1111;   // # - fila[3], col[2]
            8'b1000_1000: num = 4'b1101;  // D
            default: num = 4'b0000;
        endcase
        end
endmodule
