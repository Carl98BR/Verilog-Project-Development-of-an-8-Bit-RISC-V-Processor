module registerFile(input we3, clk, rst,
                    input [4:0] wa3, ra1, ra2,
                    input [31:0] wd3,
                    output reg [31:0] rd1, rd2);
  
  reg [31:0] register [0:31];
  
  integer i;
  //lógica de escrita
  always @ (posedge clk, negedge rst)
    begin
      if (!rst)
        for (i = 0; i < 32; i = i + 1)
          register[i] <= 32'b0;

      else if(we3)
        register[wa3] <= wd3;
      register[0] <= 32'b0;
    end		
  
  //lógica de leitura
  always @ (*)
    begin
      rd1 = register[ra1];
      rd2 = register[ra2];
    end
endmodule
