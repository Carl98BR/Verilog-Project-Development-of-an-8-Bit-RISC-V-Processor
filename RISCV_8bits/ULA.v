module ULA(input signed [31:0] SrcA, SrcB,
					 input [2:0] ULAControl,
					 output reg [31:0] ULAResult,
					 output Z);

	always @ (*)
		case(ULAControl)
			3'b000	: ULAResult = SrcA + SrcB;
			3'b001	: ULAResult = SrcA - SrcB;
			3'b010	: ULAResult = SrcA & SrcB;
			3'b011	: ULAResult = SrcA | SrcB;
			3'b100	: ULAResult = SrcA ^ SrcB;
			3'b101	: ULAResult = SrcA < SrcB;
			3'b110	: ULAResult = SrcA << SrcB;
			3'b111	: ULAResult = SrcA >> SrcB;
			default	: ULAResult = 32'bx;
		endcase
		
	assign Z = ~|ULAResult;
endmodule
