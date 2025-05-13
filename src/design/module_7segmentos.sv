  module module_7segmentos(input logic[3:0] data,
                    output logic[6:0] segmentos);
 always_comb
 case(data)
                    // abc_defg
 4'b0000: segmentos=7'b111_1110;
 4'b0001: segmentos=7'b011_0000;
 4'b0010: segmentos=7'b110_1101;
 4'b0011: segmentos=7'b111_1001;
 4'b0100: segmentos=7'b011_0011;
 4'b0101: segmentos=7'b101_1011;
 4'b0110: segmentos=7'b101_1111;
 4'b0111: segmentos=7'b111_0000;
 4'b1000: segmentos=7'b111_1111;
 4'b1001: segmentos=7'b111_0011;
 default:segmentos=7'b000_0000;
 endcase
 endmodule