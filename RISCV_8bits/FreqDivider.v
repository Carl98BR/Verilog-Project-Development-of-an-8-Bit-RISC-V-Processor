//DIVIDOR DE FREQUÊNCIA PARA CLOCK, COM ENTRADA E SAÍDA PARAMETRIZADA
module FreqDivider #(parameter INPUT_FREQUENCY = 26'd50_000_000,
                     		   OUTPUT_FREQUENCY = 1'b1)
                    (input clk_in,
                     output reg clk_out);
  
  parameter DIVIDER = INPUT_FREQUENCY / (2 * OUTPUT_FREQUENCY) - 1;  
  
  reg [$clog2(INPUT_FREQUENCY)-1:0] counter;
  
  always @ (posedge clk_in)
	 begin
      if (counter >= DIVIDER)
        begin
          counter <= 0;
          clk_out = ~clk_out;
        end
      else
        counter <= counter + 1;
	  end
endmodule
