`timescale 1ns/1ns
module module_deco2a4_tb;
//inputs
reg clk;
reg rst;
reg stop;
reg [1:0] in;
//outputs
wire [1:0] count;
wire [3:0] out;

 // instancia del contador de 2 bits y el decodificador 2 a 4
module_2bitcounter dut (
    .clk(clk),
    .rst(rst),
    .stop(stop),
    .count(count));
module_deco2a4 dut2 (
    .in(count),
    .out(out)
);

// Generación del reloj
initial begin
    clk = 0;
    forever #10 clk = ~clk; // Generación de reloj con un periodo de 20 unidades de tiempo
end
initial begin
$monitor( "At time %t, count = %b, out = %b", $time, count, out);
// Proceso de prueba
    rst = 1; // Reiniciar el sistema
    #5;      // Esperar un corto tiempo antes de liberar el reinicio
    rst = 0; stop = 0; // Liberar el reinicio
    #100;    // Esperar un tiempo para observar el comportamiento del contador
    stop = 1; // Detener el contador
    #20;      // Esperar un corto tiempo
    $stop;   // Detener la simulación
end

initial begin
    $dumpfile("module_deco2a4_tb.vcd");
    $dumpvars(0, module_deco2a4_tb);
end
endmodule