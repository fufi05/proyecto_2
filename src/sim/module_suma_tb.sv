`timescale 1ns/1ns

module module_suma_tb;
  reg [11:0] a,b;
  wire [12:0] s;

  // Instantiate the module under test
  module_suma dut (
    .a(a),
    .b(b),
    .s(s)
  );
    always begin
      // Initialize inputs
      a = 12'b0;
      b = 12'b0;
      $monitor("Time: %0t | A: %b | B: %b | Suma: %b", $time, a, b,s);
      // Apply test cases
        #50 a = 12'b0001_0011_0000; b = 12'b0001_0000_0000; // Test case 1
        #50 a = 12'b0001_0000_0000; b = 12'b0000_0000_0001;  // Test case 2
        #50 a = 12'b0000_0000_0010; b = 12'b0000_0000_0001;  // Test case 3
        #50 a = 12'b0000_0010_0000; b = 12'b0000_0001_0000;  // Test case 4
        #50 a = 12'b0010_0000_0000; b = 12'b0011_0000_0000;  // Test case 5
        $finish;
    end
  initial begin
    $dumpfile("module_suma_tb.vcd");
    $dumpvars(0, module_suma_tb);
    end
endmodule