module module_debouncer(input logic btn,
                        input logic clk,
                        input logic rst,
                        output logic tecla);
    logic n1,n2,n3,n4;
    dff dff1(.d(btn), .clk(clk), .rst(rst), .q(n1)); // D flip-flop 1
    dff dff2(.d(n1), .clk(clk), .rst(rst), .q(n2)); // D flip-flop 2
    assign n3 = ~(n1 ^ n2); // NXOR
    contador cont(.clk(clk), .rst(rst), .in(n3), .flg(n4)); // Contador
    endff endff1(.clk(clk), .rst(rst), .en(n4), .d(n2), .q(tecla)); // Enable flip-flop 
endmodule

// Modulos componentes del debouncer

//Contador
module contador(input logic clk,
                input logic rst,
                input logic  in,
                output logic flg );
    logic [8:0] count;
    always_ff @ (posedge clk, posedge rst) begin
        if (rst) begin
            count <= 0; flg <= 0;
        end
        else if (in == 1'b1) begin
            count <= (count == 4) ? 0 : count + 1; 
            flg <= (count != 4 ) ? 0 : 1; // Flag = 1 cuando count llega a 5
        end
        else if (in == 1'b0) begin
            count <= 0; flg <= 0; // Resetea count y flag si in no es 1
        end
    end
endmodule

// Enable flip-flop
module endff ( input  logic    clk,
               input  logic  rst, 
               input  logic     en, 
               input  logic      d, 
               output logic      q);

  // enable and asynchronous rst
 logic q_reg, q_reg_d;

    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            q_reg   <= 1'b0;
            q_reg_d <= 1'b0;
        end
        else if (en) begin
            q_reg   <= d;
            q_reg_d <= q_reg; // para detección de flanco
        end
    end

    assign q = en && (q_reg && ~q_reg_d); // flanco de subida en 'd' cuando 'en' está activo

endmodule 


// D flip-flop
module dff(input logic  d,
           input logic clk,
           input logic rst, 
           output logic q);

    always_ff @ (posedge clk, posedge rst) begin
        q <= rst ? 1'b0 : d;
    end
endmodule

