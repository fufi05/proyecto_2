`timescale 1ns / 1ns
// testbench verilog code for debouncing button without creating another clock
module module_debouncer_tb;
 // Inputs
 reg btn;
 reg clk;
 reg rst;
 // Outputs
 wire tecla;
 // Instantiate the debouncing Verilog code
 module_debouncer dut (
  .btn(btn), 
  .clk(clk), 
  .rst(rst),
  .tecla(tecla)
 );
 initial begin
  clk = 0;
 forever #10 clk = ~clk; // Clock generation with a period of 100 time units
 end
 initial begin
    rst = 1; // Reset the system
  #1;
  rst = 0;
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
 end 
 initial begin
    $dumpfile("module_debouncer_tb.vcd");
    $dumpvars(0, module_debouncer_tb);
end
      
endmodule