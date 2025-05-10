`timescale 1ns/1ns

module module_2bitcounter_tb;
  // Inputs
  reg clk;
  reg rst;
  reg stop;
  // Outputs
  wire [1:0] count;

  // Instantiate the 2-bit counter Verilog code
  module_2bitcounter dut (
    .clk(clk), 
    .rst(rst), 
    .stop(stop),
    .count(count)
  );

  initial begin
    clk = 0;
    forever #10 clk = ~clk; // Clock generation with a period of 20 time units
  end

  initial begin
     $monitor( "At time %t, count = %b", $time, count);
    rst = 1; // Reset the system
    #5;      // Wait for a short time before releasing reset
    rst = 0; stop = 0; // Release reset
    #1000;    // Wait for some time to observe the counter behavior
    stop = 1; // Stop the counter
    #20;      // Wait for a short time
    $stop;   // Stop the simulation
  end
   initial begin
    $dumpfile("module_2bitcounter_tb.vcd");
    $dumpvars(0, module_2bitcounter_tb);
  end
  endmodule