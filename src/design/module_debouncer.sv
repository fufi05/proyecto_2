module module_debouncer(
    input  logic btn,
    input  logic clk,
    input  logic rst,
    output logic tecla, // pulso de un ciclo
    output logic stop   // misma señal
);

    // --- sincronizador de 2 etapas para el rebote ---
    logic n1, n2;
    dff dff1(.d(btn), .clk(clk), .rst(rst), .q(n1));
    dff dff2(.d(n1), .clk(clk), .rst(rst), .q(n2));

    // --- detecta que n1 y n2 son iguales (señal estable) ---
    logic n3;
    assign n3 = ~(n1 ^ n2);

    // --- contador para asegurarse de que la señal lleve X clocks estable ---
    logic n4;
    contador cont(
        .clk(clk),
        .rst(rst),
        .in (n3),
        .flg(n4)      // n4 = 1 sólo un ciclo cuando lleva 16 clocks estable
    );

    // --- pulso de un solo ciclo: cuando ya está estable y es alto ---
    assign tecla = n4 & n2;
    assign stop  = tecla;

endmodule


//-----------------------------------------------------------------------------
// Contador: flg = 1 durante 1 ciclo cuando `in` lleva 16 clocks estables
//-----------------------------------------------------------------------------
module contador(
    input  logic       clk,
    input  logic       rst,
    input  logic       in,
    output logic       flg
);
    logic [4:0] count;
    always_ff @ (posedge clk) begin
        if (!rst) begin
            count <= 5'd0;
            flg   <= 1'b0;
        end
        else if (in) begin
            // cuenta hasta 25, luego dispara flg y resetea
            if (count == 5'd25) begin
                count <= 5'd0;
                flg   <= 1'b1;
            end else begin
                count <= count + 1;
                flg   <= 1'b0;
            end
        end
        else begin
            count <= 5'd0;
            flg   <= 1'b0;
        end
    end
endmodule


//-----------------------------------------------------------------------------
// D flip-flop con reset síncrono
//-----------------------------------------------------------------------------
module dff(
    input  logic d,
    input  logic clk,
    input  logic rst,
    output logic q
);
    always_ff @ (posedge clk) begin
        if (!rst)   q <= 1'b0;
        else        q <= d;
    end
endmodule
