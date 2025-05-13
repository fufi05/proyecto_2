 module module_fsmop(input logic clk,
                     input logic rst,
                     input logic rdy,
                     output logic load_a,
                     output logic load_b,
                     output logic load_s);
        typedef enum logic [1:0] {S0,S1,S2,S3} statetype;
        statetype state, nextstate;

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
        S0: if(rdy) nextstate = S1;
        else nextstate = S0;
        S1: if(rdy) nextstate = S2;
        else nextstate = S1;
        S2: nextstate = S3;
        S3: nextstate = S0;
    endcase
 end
  // Output logic
    assign load_a = (state == S1);
    assign load_b = (state == S2);
    assign load_s = (state == S3);
 endmodule
 