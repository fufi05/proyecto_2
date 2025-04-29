module module_sincronizador (
    input  logic [3:0] row,
    input  logic       clk,
    input  logic       rst,
    output reg       s_row
);

    logic a_row;

    always_ff @(negedge clk , posedge rst) begin
        if (rst) begin
            a_row <= 1'b0;
            s_row <= 1'b0;
        end 
        else begin
            a_row <= |row;          // Reduction OR: row[0] || row[1] || row[2] || row[3]
            s_row <= a_row;
        end
    end

endmodule
