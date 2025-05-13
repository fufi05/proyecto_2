module module_top(input logic clk,
                  input logic rst,
                  input logic [3:0] fila,
                  output logic [15:0] suma);
    logic slow_clk,stop,tecla;
    logic [1:0] col;
    logic [11:0] a,b,bcd_out;
    logic [3:0] col_o,tecla_d, bcd_u, bcd_d, bcd_c;
    logic load_u, load_d, load_c, done;

    // Instancia del divisor de frecuencia 
    module_divisor_frecuencia clk_div(
        .clk(clk),
        .rst(rst),
        .clkOut(slow_clk)
    );

    // Instancia del contador de 2 bits
    module_2bitcounter counter(
        .clk(slow_clk),
        .stop(stop),
        .rst(rst),
        .count(col)
    );

    // Instancia del decodificador 2:4
    module_deco2a4 deco(
        .in(col),
        .out(col_o)
    );

    //instancia del debouncer
    module_debouncer debouncer(
        .btn(|fila)
        .clk(slow_clk),
        .rst(rst),
        .tecla(tecla),
        .stop(stop)
    );

    // Decodificador teclado 4x4 -> hexadecimal
    module_deco_tecladohex deco_teclado(
        .fila(fila),
        .col(col_o),
        .tecla(tecla),
        .num(tecla_d),
        .rdy(rdy)
    );

    // Instancia de la FSM
    module_fsmload fsm_load(
        .clk(clk),
        .rst(rst),
        .tecla(tecla),
        .load_u(load_u),
        .load_d(load_d),
        .load_c(load_c),
    );

    //Instancia de registros de desplazamiento
    always_ff @(posedge clk , posedge rst) begin
        if (rst) begin
            bcd_u <= 4'd0;
            bcd_d <= 4'd0;
            bcd_c <= 4'd0;
        end else begin
            if (load_u) begin
                 bcd_u <= tecla_val;
            end
            if (load_d) begin
                 bcd_d <= tecla_val;
            end
            if (load_c) begin
                 bcd_c <= tecla_val;
            end
            if (load_out) begin
                bcd_out <= {bcd_u, bcd_d, bcd_c};
            end
        end
    end

    
endmodule 