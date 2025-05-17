 module module_fsmop(input logic clk,
                     input logic rst,
                     input logic rdy,
                     output logic load_a,
                     output logic load_b,
                     output logic load_s);
    parameter S0 = 4'b0001;
    parameter S1 = 4'b0010;
    parameter S2 = 4'b0100;
    parameter S3 = 4'b1000;
    logic [3:0] state, nextstate;
       // typedef enum logic [3:0] {S0,S1,S2,S3} statetype; 
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
        S0: if(rdy) begin nextstate = S1;
        end
        else begin nextstate = S0;
        end
        S1: if(rdy)  begin 
            nextstate = S2;
        end
        else begin nextstate = S1;
        end
        S2: nextstate = S3;
        S3: nextstate = S0;
        default: nextstate = S0;
    endcase
 end
  // Output logic
    assign load_a = (state == S1);
    assign load_b = (state == S2);
    assign load_s = (state == S3);
 endmodule
 