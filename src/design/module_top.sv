module module_top(input logic clk,
                  input logic rst,
                  input logic [3:0] fila,
                  input logic [3:0] columna,
                  output logic [15:0] suma);
    logic stop, tecla, load_u, load_d, load_c, rdy, load_a, load_b;
    logic [1:0] col, slow_clk;
    logic [11:0] a, b, bcd_out;
    logic [3:0] col_o, tecla_d, bcd_u, bcd_d, bcd_c,tecla_val;

    // Instancia del divisor de frecuencia 
    module_count clk_div(
        .clk(clk),
        .rst(rst),
        .count_out(slow_clk)
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
        .btn(|fila),
        .clk(slow_clk),
        .rst(rst),
        .tecla(tecla),
        .stop(stop)
    );

    // Decodificador teclado 4x4 -> hexadecimal
    module_deco_tecladohex deco_teclado(
        .fila(fila),
        .col(columna),
        .tecla(tecla),
        .num(tecla_d)
    );

    // Instancia de la FSM de carga
    module_fsmload fsm_load(
        .clk(clk),
        .rst(rst),
        .tecla(tecla),
        .load_u(load_u),
        .load_d(load_d),
        .load_c(load_c),
        .load_out(rdy)
    );

    //Instancia de registros de desplazamiento
    always_ff @(posedge clk) begin
        if (!rst) begin
            bcd_u <= 4'd0;
            bcd_d <= 4'd0;
            bcd_c <= 4'd0;
        end 
        else begin
            if (load_u) begin
                 bcd_u <= tecla_val;
            end
            if (load_d) begin
                 bcd_d <= tecla_val;
            end
            if (load_c) begin
                 bcd_c <= tecla_val;
            end
            if (rdy) begin
                bcd_out <= {bcd_u, bcd_d, bcd_c};
            end
        end
    end

    // Instancia de la FSM de operandos
    module_fsmop fsm_op(
        .clk(clk),
        .rst(rst),
        .rdy(rdy),
        .load_a(load_a),
        .load_b(load_b)
    );

    // Registro de desplazamiento para la FSM de operandos
    always_ff @(posedge clk)begin
        if (!rst)begin
            a <= '0;
            b <= '0;
        end
        else begin
            if (load_a) begin
                a<= bcd_out;
            end
            if (load_b) begin
                b <= bcd_out;
            end
        end
    end

    // Instancia de la suma 
    module_suma sumador(
        .a(a),
        .b(b),
        .s(suma)
    );

    module_contador module_count (
        .clk(clk),
        .rst(rst),
    );
    module_7segmentos module_7segmentos(
        .bcd_u()
    );
    module_mux_onehot mux_onehot(
        .count_out(sel)
    );
    module_mux_4to1 mux_4to1(
        .count_out(sel)
    );
endmodule 