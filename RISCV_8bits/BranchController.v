module BranchController(input signed [31:0] SrcA, SrcB,
											 input [2:0] Funct3,
											 input isBranch,
											 output reg Branch);
											 
	always @ (*)
		if(isBranch)
			case(Funct3)
				3'b000		:	Branch = SrcA == SrcB;
				3'b001		:	Branch = SrcA != SrcB;
				3'b100		:	Branch = SrcA < SrcB;
				3'b101		:	Branch = SrcA >= SrcB;
				default		:	Branch = 1'bx;
			endcase
		else
			Branch = 1'b0;
endmodule
