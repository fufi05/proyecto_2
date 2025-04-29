/* Decode the asserted row and col
                                    col[0] col[1] col[2] col[3]
        row[0]                      1       2       3       A
        row[1]                      4       5       6       B
        row[2]                      7       8       9       C
        row[3]                      *       0       #       D           */

module module_teclado_hex(
    input logic [3:0] row,
    input logic s_row,
    input logic clk,
    input logic rst,
    output logic [3:0] code,
    output logic valido,
    output logic [3:0] col
    );
    
    reg [5: 0] state, next_state;
    
   // One-hot encoding
    parameter S_0 = 6'b000001, S_1 = 6'b000010, S_2 = 6'b000100;
    parameter S_3 = 6'b001000, S_4 = 6'b010000, S_5 = 6'b100000;
    assign valido = ((state == S_1) | (state == S_2) | (state == S_3) | (state == S_4)) & row;
    always @ (row or col)
    case ({row, col})
        8'b0001_0001: code = 1; 
        8'b0001_0010: code = 2;
        8'b0001_0100: code = 3; 
        8'b0001_1000: code = 10; // A
        8'b0010_0001: code = 4; 
        8'b0010_0010: code = 5;
        8'b0010_0100: code = 6;
        8'b0010_1000: code = 11; // B
        8'b0100_0001: code = 7;
        8'b0100_0010: code = 8;
        8'b0100_0100: code = 9;       
        8'b0100_1000: code = 12;  // C
        8'b1000_0001: code = 4'bxxxx;   // * (not used)
        8'b1000_0010: code = 0;        
        8'b1000_0100: code = 4'bxxxx;   // # (not used)
        8'b1000_1000: code = 15;  // D
        default: code = 0;                     //Arbitrary choice
    endcase
    always @(posedge clk , posedge rst)
    if (rst) state <= S_0;
    else state <= next_state;
    always@ (*)                 // Next-state logic
    begin next_state = state; col = 0;
    case (state)
        //Assert all columns
        S_0: begin col = 15; if (s_row) next_state = S_1; end
        //Assert column 0
        S_1: begin col = 1; if (row) next_state = S_5; else next_state = S_2; end
        //Assert column 1
        S_2: begin col = 2; if (row) next_state = S_5; else next_state = S_3; end
        // Assert column 2
        S_3: begin col = 4; if (row) next_state = S_5; else next_state= S_4; end
       // Assert column 3
        S_4: begin col = 8; if (row) next_state = S_5; else next_state = S_0; end
        // Assert all rows
        S_5: begin col = 15; if (row ==0) next_state = S_0; end
    endcase
    end
endmodule