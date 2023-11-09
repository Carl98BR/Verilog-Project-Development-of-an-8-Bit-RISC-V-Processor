//MULTIPLEXADOR 2:1 COM ENTRADA E SAÍDA DE N BITS
module mux2x1 #(parameter N = 32)(input [N-1:0] i0, i1, input sel, output reg [N-1:0] out);
  
  always @ (*)
    case (sel)
      1'b0	:	out = i0;
      1'b1	:	out = i1;
      default:	out = i0;
    endcase
endmodule
