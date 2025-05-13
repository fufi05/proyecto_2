module divisor_frecuencia (
    input  logic clk,
    input  logic rst,
    output logic clkOut
);

    logic [1:0] count;

    always_ff @(posedge clk , posedge rst) begin
        if (rst) begin
        count  <= 0;
        clkOut <= 0;
    end
    else begin
        count <= count + 1;
        if (count == 2'b10) begin
            count  <= 0;
            clkOut <= ~clkOut;
      end
    end
    end

endmodule

