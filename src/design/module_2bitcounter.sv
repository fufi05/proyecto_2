module module_2bitcounter( input  logic  clk,
    input  logic rst,     // Reset asíncrono activo en bajo
    input  logic stop,        // Enable
    output logic [1:0] count_o);
    logic [1:0] count; // Contador de 2 bits

    always_ff @(posedge clk) begin
        if (!rst) begin
           count <= 2'b00; 
        end
        else if (stop) begin
            count <= count;
        end
        else begin
            count <= count + 1'b1;
        end
    end

    assign count_o = count; // Salida del contador
endmodule 
