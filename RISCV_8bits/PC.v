module PC(input clk, rst, input [7:0] PCin, output reg [7:0] PC);

	always @ (posedge clk, negedge rst)
		if (!rst)
			PC <= 8'h00;
		else
			PC <= PCin;
endmodule
