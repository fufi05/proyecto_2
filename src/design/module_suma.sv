module module_suma (
    input logic [11:0] a,b,
    output logic [12:0] s
    );
    // suma de 12 bits 
    assign s = a + b;
endmodule