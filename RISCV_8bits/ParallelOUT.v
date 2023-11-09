module ParallelOUT(input EN, clk, rst,
						input [31:0] Address, RegData,
						output reg [31:0] DataOut);
						
	always @ (posedge clk, negedge rst)
		if (!rst)
			DataOut <= 0;
		else if(EN & Address == 32'hFFFFFFFF)
			DataOut <= RegData;
endmodule
