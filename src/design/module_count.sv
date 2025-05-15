module module_count #(
    parameter count = 1350000
)(
    input logic clk,
    input logic rst,
    output logic count_out
);
    localparam width_count = $clog2(count);
    logic [width_count-1:0] counter = '0;
    logic count_o;

    always_ff @( posedge clk ) begin
        if (!rst)begin
            counter <= '0;
            count_o <= '0;
        end
        else if(counter == count)begin
            counter <= '0;
            count_o <= count_o + 1'b1;
        end
        else begin
            counter <= counter + 1'b1;
        end
    end
    assign count_out = count_o;
endmodule