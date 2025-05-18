`timescale 1ns/1ns

module module_top_tb;

    logic clk, rst;
    logic [3:0] fila;
    logic [15:0] suma;

    // Instancia del DUT
    module_top dut (
        .clk(clk),
        .rst(rst),
        .fila(fila),
        .suma(suma)
    );

    // Clock lento para depuración
    initial clk = 0;
    always #1 clk = ~clk;


    initial begin
        rst = 1'b0;
        fila = 4'b0;
        #20;
        rst = 1'b1;
        #20;
        fila = 4'b0001;
        #20;
        fila = 4'b0100;
        #20;
        fila = 4'b0001;
        #20;
        fila = 4'b0100; 
        #20;
        fila = 4'b0001;
        #20;
        fila = 4'b0100;
        #20;

        // Esperar resultado
        #550;
        $display("filas presionadas: %b, | Salida: %h", fila,suma);
        $finish;
    end
    initial begin
        $dumpfile("module_top_tb.vcd");
        $dumpvars(0, module_top_tb);
    end
endmodule
