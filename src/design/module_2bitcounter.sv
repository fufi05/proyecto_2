module module_2bitcounter( input  logic clk,
    input  logic rst,     // Reset asíncrono activo en bajo
    input  logic en,        // Enable
    output logic [1:0] count );
    always_ff @(posedge clk , posedge rst) begin
        if (rst)
            count <= 2'b00;
        else if (en)
            count <= count + 1;
    end
endmodule