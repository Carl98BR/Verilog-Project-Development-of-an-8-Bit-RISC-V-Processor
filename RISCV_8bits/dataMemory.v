module dataMemory(input clk, rst, WE,
								   input [31:0] A, WD,
								   output reg [31:0] RD);
			
	reg [31:0] memory [0:1023];
	
	initial
		$readmemh("data_memory.txt", memory);
	
	always @ (posedge clk, negedge rst)
		if (!rst)
			$readmemh("data_memory.txt", memory);
		else if (WE)
			memory[A] <= WD;
				
	always @ (*)
		RD = memory[A];
endmodule
