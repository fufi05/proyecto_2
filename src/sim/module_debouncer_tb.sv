`timescale 1ms / 1ms
// testbench verilog code for debouncing button without creating another clock
module module_debouncer_tb;
 // Inputs
 reg pb_1;
 reg clk;
 // Outputs
 wire pb_out;
 // Instantiate the debouncing Verilog code
 module_debouncer dut (
  .pb_1(pb_1), 
  .clk(clk), 
  .pb_out(pb_out)
 );
 initial begin
  clk = 0;
  forever #1 clk = ~clk;
 end
 initial begin
  pb_1 = 0;
  #10;
  pb_1=1;
  #20;
  pb_1 = 0;
  #10;
  pb_1=1;
  #30; 
  pb_1 = 0;
  #10;
  pb_1=1;
  #40;
  pb_1 = 0;
  #10;
  pb_1=1;
  #30; 
  pb_1 = 0;
  #10;
  pb_1=1; 
  #1000; 
  pb_1 = 0;
  #10;
  pb_1=1;
  #20;
  pb_1 = 0;
  #10;
  pb_1=1;
  #30; 
  pb_1 = 0;
  #10;
  pb_1=1;
  #40;
  pb_1 = 0; 
 end 
 initial begin
    $dumpfile("module_debouncer_tb.vcd");
    $dumpvars(0, module_debouncer_tb);
end
      
endmodule