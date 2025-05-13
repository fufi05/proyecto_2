module module_top(input logic clk,
                  input logic rst,
                  input logic [3:0] fila,
                  input logic [3:0] columna,
                  output logic [15:0] suma);
    logic stop, tecla, load_u, load_d, load_c, rdy, load_a, load_b,load_s;
    logic [1:0] col, slow_clk,out2;
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
        .load_b(load_b),
        .load_s(load_s)
    );

    // Registro de desplazamiento para la FSM de operandos
    always_ff @(posedge clk)begin
        if (!rst)begin
            a <= '0;
            b <= '0;
        end
        else begin
            if (load_a) begin
                a <= bcd_out;
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

    //Sistema de despliegue de los operandos y suma
    // Señales internas
    logic [1:0] fuente_sel;
    logic [3:0] a_u,a_d,a_c,b_u,b_d,b_c,s_u,s_d,s_c,s_um,mux_val_0, mux_val_1, mux_val_2, mux_val_3;
    logic [6:0] segmentos;

    // Selector de la señal de salida
    always_ff @(posedge clk) begin
    if (!rst) begin
        fuente_sel <= 2'b00; // Default: mostrar A
    end 
    else begin
        if (load_a)
            fuente_sel <= 2'b00; // Mostrando A
        else if (load_b)
            fuente_sel <= 2'b01; // Mostrando B
        else if (load_s)
            fuente_sel <= 2'b10; // Mostrando resultado
        end
    end 

    assign a_u = a[3:0];
    assign a_d = a[7:4];
    assign a_c = a[11:8];
    assign b_u = b[3:0];
    assign b_d = b[7:4];
    assign b_c = b[11:8];
    assign s_u = suma[3:0];
    assign s_d = suma[7:4];
    assign s_c = suma[11:8];
    assign s_um = suma[15:12]; 
    // Instancia de que valores se van a mostrar
    always_comb begin
    // Default = A
    case (fuente_sel)
        2'b00: begin // A
            mux_val_0 = a_u;
            mux_val_1 = a_d;
            mux_val_2 = a_c;
            mux_val_3 = 4'd0;
        end
        2'b01: begin // B
            mux_val_0 = b_u;
            mux_val_1 = b_d;
            mux_val_2 = b_c;
            mux_val_3 = 4'd0;
        end
        2'b10: begin // Suma
            mux_val_0 = s_u;
            mux_val_1 = s_d;
            mux_val_2 = s_c;
            mux_val_3 = s_um;
        end
        default: begin
            mux_val_0 = 4'd0;
            mux_val_1 = 4'd0;
            mux_val_2 = 4'd0;
            mux_val_3 = 4'd0;
        end
    endcase
    end

    module_mux_onehot mux_onehot(
        .sel(slow_clk),
        .out2(out2)
    );

    module_mux_4to1 valores(
        .unidades(mux_val_0),
        .decenas(mux_val_1),
        .centenas(mux_val_2),
        .millares(mux_val_3),
        .sel(fuente_sel),
        .out(out)
    );
    module_7segmentos unidades(
        .data(mux_val_0),
        .segmentos(segmentos)
        //de aqui salen las unidades en forma para el siete segmentos y ser mandadas al mux
    );
    module_7segmentos decenas(
        .data(mux_val_1),
        .segmentos(segmentos)
        //de aqui salen las decenas en forma para el siete segmentos y ser mandadas al mux
    );
    module_7segmentos centenas(
        .data(mux_val_2),
        .segmentos(segmentos)
        //de aqui salen las centanas en forma para el siete segmentos y ser mandadas al mux
    );
    module_7segmentos millares(
        .data(mux_val_3),
        .segmentos(segmentos)
        //de aqui salen las unidades de millar en forma para el siete segmentos y ser mandadas al mux
    );
endmodule 