`timescale 1ms / 1ms


module module_teclado_hex_tb ();
    wire            [3:0] code;
    wire            valido;
    wire            [3:0] col;
    wire            [3:0] row;
    reg             clk, rst;
    reg             [15: 0] key;
    reg             [39: 0] presionado;
    reg             [3: 0] code_db;
    parameter  [39: 0] Key_0 = "Key_1";
    parameter  [39: 0] Key_1 = "Key_2";
    parameter  [39: 0] Key_2 = "Key_3";
    parameter  [39: 0] Key_3 = "Key_A";
    parameter  [39: 0] Key_4 = "Key_4";
    parameter  [39: 0] Key_5 = "Key_5";
    parameter  [39: 0] Key_6 = "Key_6";
    parameter  [39: 0] Key_7 = "Key_B";
    parameter  [39: 0] Key_8 = "Key_7";
    parameter  [39: 0] Key_9 = "Key_8";
    parameter  [39: 0] Key_10 = "Key_9"; 
    parameter  [39: 0] Key_11 = "Key_C";
    parameter  [39: 0] Key_12 = "Key_*"; 
    parameter  [39: 0] Key_13 = "Key_0"; 
    parameter  [39: 0] Key_14 = "Key_#";
    parameter  [39: 0] Key_15 = "Key_D";
    parameter  [39: 0] None = "None";
    integer        j, k;
    always @(key) begin                                                   // "one-hot" codeo for pressed key
    case (key)
        16'h0000: presionado = None;
        16'h0001: presionado = Key_0;              //Key = 0000 0000 0000 0001
        16'h0002: presionado = Key_1;              //Key = 0000 0000 0000 0010
        16'h0004: presionado = Key_2;              //Key = 0000 0000 0000 0100
        16'h0008: presionado = Key_3;              //Key = 0000 0000 0000 1000
        16'h0010: presionado = Key_4;
        16'h0020: presionado = Key_5;
        16'h0040: presionado = Key_6;
        16'h0080: presionado = Key_7;
        16'h0100: presionado = Key_8;
        16'h0200: presionado = Key_9;
        16'h0400: presionado = Key_10;
        16'h0800: presionado = Key_11;
        16'h1000: presionado = Key_12;
        16'h2000: presionado = Key_13;
        16'h4000: presionado = Key_14;
        16'h8000: presionado = Key_15;
        default: presionado = None;
    endcase
    end
    module_teclado_hex M1( .row(row), .s_row(s_row), .clk(clk), .rst(rst), .code(code), .valido(valido), .col(col));
    module_r_signal M2(.key(key), .col(col), .row(row));
    module_sincronizador M3(.row(row), .clk(clk), .rst(rst), .s_row(s_row));
    module_debouncer db1(.pb_1(code[0]), .clk(clk), .pb_out(code_db[0]));
    module_debouncer db2(.pb_1(code[1]), .clk(clk), .pb_out(code_db[1]));
    module_debouncer db3(.pb_1(code[2]), .clk(clk), .pb_out(code_db[2]));
    module_debouncer db4(.pb_1(code[3]), .clk(clk), .pb_out(code_db[3]));
    
    initial #2000 $finish;
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial begin rst = 1; #10 rst = 0; end
    initial 
        begin 
            for (k = 0; k<= 1; k = k+1) 
                begin 
                    key = 0;
                    #20
                    for (j = 0; j <= 16; j = j+1) 
                        begin
                            #20 key[j] = 1; 
                            #60 key = 0; 
                        end 
                end 
        end
    initial begin
        $dumpfile("module_teclado_hex_tb.vcd");
        $dumpvars(0, module_teclado_hex_tb);
    end
endmodule