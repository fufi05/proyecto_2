`timescale 1ns/1ns

module module_deco_tecladohex_tb;
    // Inputs
    reg [3:0] fila;
    reg [3:0] col;
    reg tecla;

    // Outputs
    wire [3:0] num;
    wire rdy;

    // Instantiate the module under test
    module_deco_tecladohex uut (
        .fila(fila),
        .col(col),
        .tecla(tecla),
        .num(num),
        .rdy(rdy)
    );

    initial begin
        // Monitor the outputs
        $monitor("Time: %0t | fila: %b | col: %b | tecla: %b | num: %b | rdy: %b", 
                 $time, fila, col, tecla, num, rdy);
        // Initialize inputs
        fila = 4'b0000;
        col = 4'b0000;
        tecla = 1'b0;
        #10;
        // Test case 1: Tecla 1
        fila = 4'b0001; col = 4'b0001; tecla = 1;
        #10;
        // Test case 2: Tecla 2
        fila = 4'b0001; col = 4'b0010; tecla = 1;
        #10;
        // Test case 3: Tecla 3
        fila = 4'b0001; col = 4'b0100; tecla = 1;
        #10;
        // Test case 4: Tecla A
        fila = 4'b0001; col = 4'b1000; tecla = 1;
        #10;
        // Test case 5: Tecla 4
        fila = 4'b0010; col = 4'b0001; tecla = 1;
        #10;
        // Test case 6: Tecla 5
        fila = 4'b0010; col = 4'b0010; tecla = 1;
        #10;
        // Test case 7: Tecla 6
        fila = 4'b0010; col = 4'b0100; tecla = 1;
        #10;
        // Test case 8: Tecla B
        fila = 4'b0010; col = 4'b1000; tecla = 1;
        #10;
        // Test case 9: Tecla 7
        fila = 4'b0100; col = 4'b0001; tecla = 1;
        #10;
        // Test case 10: Tecla 8
        fila = 4'b0100; col = 4'b0010; tecla = 1;
        #10;
        // Test case 11: Tecla 9
        fila = 4'b0100; col = 4'b0100; tecla = 1;
        #10;
        // Test case 12: Tecla C
        fila = 4'b0100; col = 4'b1000; tecla = 1;
        #10;
        // Test case 13: Tecla *
        fila = 4'b1000; col = 4'b0001; tecla = 1;
        #10;
        // Test case 14: Tecla 0
        fila = 4'b1000; col = 4'b0010; tecla = 1;
        #10;
        // Test case 15: Tecla #
        fila = 4'b1000; col = 4'b0100; tecla = 1;
        #10;
        // Test case 16: Tecla D
        fila = 4'b1000; col = 4'b1000; tecla = 1;
        #10;
        // Test case 17: No tecla pressed
        fila = 4'b0000; col = 4'b0000; tecla = 0;
        #10;
        // Test case 18: Invalid input
        fila = 4'b0001; col = 4'b0000; tecla = 1;
        #10;
        // Test case 19: Invalid input
        fila = 4'b0001; col = 4'b0001; tecla = 0;
        #10;
        // Test case 20: Invalid input
        fila = 4'b0000; col = 4'b0010; tecla = 1;
        #10;
        $finish;
    end
   initial begin
    $dumpfile("module_deco_tecladohex_tb.vcd");
    $dumpvars(0, module_deco_tecladohex_tb);
end

endmodule