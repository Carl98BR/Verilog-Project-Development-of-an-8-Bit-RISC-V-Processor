module InstructionMemory(input [7:0] A, output[31:0] RD);

	reg [31:0] memory [0:1023];

	initial
		$readmemh("./data_instruction.txt", memory);
		
	assign RD = memory[A / 4];
endmodule
