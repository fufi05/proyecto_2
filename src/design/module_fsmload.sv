 module module_fsmload(input logic clk,
                     input logic rst,
                     input logic tecla,
                     output logic load_u,
                     output logic load_d,
                     output logic load_c,
                     output logic load_out);

    parameter S0 = 5'b00001;
    parameter S1 = 5'b00010;
    parameter S2 = 5'b00100;
    parameter S3 = 5'b01000;
    parameter S4 = 5'b10000;
    logic [4:0] state, nextstate;
       // typedef enum logic [4:0] {S0,S1,S2,S3,S4} statetype; 
       // statetype state, nextstate;

 //state register
 always_ff @(posedge clk) begin
            if(!rst) begin 
                state <= S0;
            end
            else begin
                state <= nextstate;
            end
        end
 //next state logic
 always_comb begin
    case(state)
        S0: if(tecla) nextstate = S1;
        else nextstate = S0;
        S1: if(tecla) nextstate = S2;
        else nextstate = S1;
        S2: if(tecla) nextstate = S3;
        else nextstate = S2;
        S3: nextstate = S4;
        S4: nextstate = S0;
        default: nextstate = S0;
    endcase
 end
  // Output logic
    assign load_u = (state == S1);   // Señal activa durante S1
    assign load_d = (state == S2);   // Señal activa durante S2
    assign load_c = (state == S3);   // Señal activa durante S3
    assign load_out = (state == S4);   // Procesamiento completo
 endmodule
 