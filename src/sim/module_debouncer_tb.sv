`timescale 1ns / 1ns
// testbench verilog code for debouncing button without creating another clock
module module_debouncer_tb;
 // Inputs
 logic btn;
 logic clk;
 logic rst;
 // Outputs
 logic stop;
 logic tecla;
 // Instantiate the debouncing Verilog code
 module_debouncer dut (
  .btn(btn), 
  .clk(clk), 
  .rst(rst),
  .tecla(tecla),
  .stop(stop)
 );
 initial begin
  clk = 0;
 forever #10 clk = ~clk; // Clock generation with a period of 100 time units
 end
 initial begin
    rst = 1'b0; // Reset the system
  #10;
  rst = 1'b1;
  btn = 0;
  #10;
  btn=1;
  #20;
  btn = 0;
  #10;
  btn=1;
  #30; 
  btn = 0;
  #10;
  btn=1;
  #40;
  btn = 0;
  #10;
  btn=1;
  #30; 
  btn = 0;
  #10;
  btn=1; 
  #1000; 
  btn = 0;
  #10;
  btn=1;
  #20;
  btn = 0;
  #10;
  btn=1;
  #30; 
  btn = 0;
  #10;
  btn=1;
  #40;
  btn = 0; 
  #100;
  $finish; // End the simulation
 end 
 initial begin
    $dumpfile("module_debouncer_tb.vcd");
    $dumpvars(0, module_debouncer_tb);
end
      
endmodule