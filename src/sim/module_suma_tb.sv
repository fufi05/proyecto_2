`timescale 1ns/1ns

module module_suma_tb;
  reg [2:0] a,b,c;
  wire cout;

  // Instantiate the module under test
  module_suma dut (
    .a(a),
    .b(b),
    .c(c),
    .suma(cout)
  );
    always begin
      // Initialize inputs
      a = 3'd000;
      b = 3'd000;
      c = 3'd000;
      $monitor("Time: %0t | A: %b | B: %b | C: %b | Suma: %b", $time, a, b, c, cout);
      // Apply test cases
        #50 a = 3'd136; b = 3'd004; c = 3'd100; // Test case 1
        #50 a = 3'h001; b = 3'h0AC; c = 3'h032; // Test case 2
        #50 a = 3'h002; b = 3'h0AD; c = 3'h033; // Test case 3
        #50 a = 3'h003; b = 3'h0AE; c = 3'h034; // Test case 4
        #50 a = 3'h004; b = 3'h0AF; c = 3'h035; // Test case 5
        $finish;
    end
  initial begin
    $dumpfile("module_suma_tb.vcd");
    $dumpvars(0, module_suma_tb);
    end
endmodule