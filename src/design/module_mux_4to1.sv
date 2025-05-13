module mux_4to1 (
    input [6:0] a,                 
    input [6:0] b,                 
    input [6:0] c,                 
    input [6:0] d,                 
    input [1:0] sel,               
    output reg [6:0] out
);
    always @(a or b or c or d or sel) begin
        case(sel)
            2'b00 : out <= a;
            2'b01 : out <= b;
            2'b10 : out <= c;
            2'b11 : out <= d;
        endcase
    end
endmodule