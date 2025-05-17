module module_debouncer(input logic btn,
                        input logic clk,
                        input logic rst,
                        output logic tecla, // se deben llamar 4 en la entrada de las filas
                        output logic stop); // y luego poner un OR para que salga una sola tecla
    logic n1,n2,n3,n4;
    dff dff1(.d(btn), .clk(clk), .rst(rst), .q(n1)); // D flip-flop 1
    dff dff2(.d(n1), .clk(clk), .rst(rst), .q(n2)); // D flip-flop 2
    assign n3 = ~(n1 ^ n2); // NXOR
    contador cont(.clk(clk), .rst(rst), .in(n3), .flg(n4)); // Contador
    endff endff1(.clk(clk), .rst(rst), .en(n4), .d(n2), .q(tecla)); // Enable flip-flop 
    assign stop = tecla; // Salida stop
endmodule

// Modulos componentes del debouncer

//Contador
module contador(input logic clk,
                input logic rst,
                input logic  in,
                output logic flg );
    logic [3:0] count;
    always_ff @ (posedge clk) begin
        if (!rst) begin
            count <= 4'b0000; flg <= 1'b0;
        end
        else if (in == 1'b1) begin
            count <= (count == 4'b1111) ? 4'b0000 : count + 4'b1; 
            flg <= (count != 4'b1111 ) ? 1'b0 : 1'b1; // Flag = 1 cuando count llega a 5
        end
        else begin
            count <= 4'b0000; flg <= 1'b0; // Resetea count y flag si in no es 1
        end
    end
endmodule

// Enable flip-flop
 module endff(input logic clk,
              input logic rst,
              input logic en,
              input logic d,
              output logic q);
 //asynchronous reset
 always_ff@(posedge clk) begin
        if (!rst) begin q<=1'b0;
         end
        else if(en) begin q<=d;
         end
 end
 endmodule


// D flip-flop
module dff(input logic  d,
           input logic clk,
           input logic rst, 
           output logic q);

    always_ff @ (posedge clk) begin
        q <= !rst ? 1'b0 : d;
    end
endmodule
