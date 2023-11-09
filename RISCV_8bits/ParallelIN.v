module ParallelIN(input [31:0] Address, DataIn, MemData,
							output reg [31:0] RegData);
								
	always @ (*)
		case(Address == 32'hFFFFFFFF)
			1'b0	:	RegData = MemData;
			1'b1	:	RegData = DataIn;
			default : RegData = 0;
		endcase
endmodule
