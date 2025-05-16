`timescale 1ns/1ns

module module_top_tb;

    logic clk, rst, stop,tecla;
    logic [3:0] fila;
   // logic [3:0] columna;
    logic [15:0] suma;

    // Instancia del DUT
    module_top dut (
        .clk(clk),
        .rst(rst),
        .stop(stop),
        .tecla(tecla),
        .fila(fila),
       // .columna(columna),
        .suma(suma)
    );

    // Clock lento para depuración
    initial clk = 0;
    always #10 clk = ~clk;

/*
    // Simular "columna activa" basada en barrido del contador interno
    function [3:0] col_to_input(input [1:0] col_sel);
        case (col_sel)
            2'd0: col_to_input = 4'b0001;
            2'd1: col_to_input = 4'b0010;
            2'd2: col_to_input = 4'b0100;
            2'd3: col_to_input = 4'b1000;
            default: col_to_input = 4'b0000;
        endcase
    endfunction
    */
/*
    // Simula una tecla (columna activa + fila activa)
    task press_key(input [3:0] fila_val, input [1:0] col_sel_sim);
        begin
            columna = col_to_input(col_sel_sim);
            fila     = fila_val;
            $display("[%0t ns] Simulando tecla (fila = %b, columna = %b)", 
                     $time, fila_val, columna);
            repeat(3) @(posedge clk);
            fila     = 4'b0000;
            columna = 4'b0000;
            repeat(4) @(posedge clk); // debounce
        end
    endtask
    */

    initial begin
        rst = 1'b0;
        fila = 4'b0;
        #20;
        rst = 1'b1;
        #20;
        fila = 4'b0001;
        tecla = 1'b1;
        stop = 1'b1;
        #20;
        tecla = 1'b0;
        stop = 1'b0;
        #20;
        fila = 4'b0100;
        stop = 1'b1;
        tecla = 1'b1; 
        #20;
        stop = 1'b0;
        tecla = 1'b0;
        #20;
        fila = 4'b0001;
        tecla = 1'b1;
        stop = 1'b1;
        #20;
        tecla = 1'b0;
        stop = 1'b0;
        #20;

        fila = 4'b0100;
        stop = 1'b1;
        tecla = 1'b1; 
        #20;
        stop = 1'b0;
        tecla = 1'b0;
        #20;

         fila = 4'b0001;
        tecla = 1'b1;
        stop = 1'b1;
        #20;
        tecla = 1'b0;
        stop = 1'b0;
        #20;

        fila = 4'b0100;
        stop = 1'b1;
        tecla = 1'b1; 
        #20;
        stop = 1'b0;
        tecla = 1'b0;
        #20;

        /*
        // Cargar A = 141 (U = 1, D = 4, C = 1)
        press_key(4'b0001, 2'd0); #10 // '1'
        press_key(4'b0010, 2'd0); #10 // '4'
        press_key(4'b0001, 2'd0); #10 // '1'

        // Cargar B = 456 (U = 6, D = 5, C = 4)
        press_key(4'b0010, 2'd3); #10 // '6'
        press_key(4'b0010, 2'd2); #10 // '5'
        press_key(4'b0010, 2'd0); #10// '4'
        */

        // Esperar resultado
        #200;
        $display("Suma esperada: 579 (BCD) | Salida: %h", suma);
        $finish;
    end
    initial begin
        $dumpfile("module_top_tb.vcd");
        $dumpvars(0, module_top_tb);
    end
endmodule
