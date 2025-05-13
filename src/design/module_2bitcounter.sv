module module_2bitcounter( input  logic [1:0] clk,
    input  logic rst,     // Reset asíncrono activo en bajo
    input  logic stop,        // Enable
    output logic [1:0] count );
    always_ff @(posedge clk) begin
        if (!rst) begin
           count <= 2'b00; 
        end
        else if (!stop) begin
            count <= count + 1;
        end
    end
endmodule 
