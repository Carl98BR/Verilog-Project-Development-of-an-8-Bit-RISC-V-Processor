module ControlUnit(input [6:0] OP, Funct7, input [2:0] Funct3,
								 output RegWrite, ULASrc, MemWrite, isBranch, Jump, AdderImmSrc,
								 output [1:0] ImmSrc, ResultSrc,
								 output [2:0] ULAControl);
	
	reg [12:0] dataBus;

	always @ (*)
		casex({OP, Funct3, Funct7})
			17'b0110011_000_0000000	: dataBus =	13'b1_xx_0_000_0_00_0_0_x; //add
			17'b0110011_000_0100000	: dataBus =	13'b1_xx_0_001_0_00_0_0_x; //sub
			17'b0110011_111_0000000	: dataBus =	13'b1_xx_0_010_0_00_0_0_x; //and
			17'b0110011_110_0000000	: dataBus =	13'b1_xx_0_011_0_00_0_0_x; //or
			17'b0010011_110_xxxxxxx	: dataBus =	13'b1_00_1_011_0_00_0_0_x; //ori
			17'b0110011_010_0000000	: dataBus =	13'b1_xx_0_101_0_00_0_0_x; //slt
			17'b0010011_000_xxxxxxx	: dataBus =	13'b1_00_1_000_0_00_0_0_x; //addi
			17'b0000011_000_xxxxxxx	: dataBus =	13'b1_00_1_010_0_01_0_0_x; //lw
			17'b0100011_000_xxxxxxx	: dataBus =	13'b0_01_1_010_1_xx_0_0_x; //sw
			17'b1100011_000_xxxxxxx	: dataBus =	13'b0_10_0_xxx_0_00_1_0_1; //beq
			17'b1100011_001_xxxxxxx	: dataBus =	13'b0_10_0_xxx_0_00_1_0_1; //bne
			17'b1100011_100_xxxxxxx	: dataBus =	13'b0_10_0_xxx_0_00_1_0_1; //blt
			17'b1100011_101_xxxxxxx	: dataBus =	13'b0_10_0_xxx_0_00_1_0_1; //bge
			17'b1101111_xxx_xxxxxxx	: dataBus =	13'b1_11_x_xxx_0_10_0_1_1; //jal
			17'b1100111_000_xxxxxxx	: dataBus =	13'b0_00_x_xxx_0_10_0_1_0; //jalr
			17'b0110011_100_0000000	: dataBus = 13'b1_xx_0_100_0_00_0_0_x; //xor
			17'b0010011_100_xxxxxxx	: dataBus = 13'b1_00_1_100_0_00_0_0_x; //xori
			17'b0010011_010_xxxxxxx	: dataBus = 13'b1_00_1_101_0_00_0_0_x; //slti
			17'b0110011_001_0000000	: dataBus =	13'b1_xx_0_110_0_00_0_0_x; //sll
			17'b0110011_101_0000000	: dataBus =	13'b1_xx_0_111_0_00_0_0_x; //srl
			17'b0010011_001_xxxxxxx	: dataBus =	13'b1_00_1_110_0_00_0_0_x; //slli
			17'b0010011_101_xxxxxxx	: dataBus =	13'b1_00_1_111_0_00_0_0_x; //srli
			default										: dataBus =	13'bx_xx_x_xxx_x_xx_x_x_x; //default
		endcase
		
	assign {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, isBranch, Jump, AdderImmSrc} = dataBus;
endmodule
