`default_nettype none //Comando para desabilitar declaração automática de wires
module Mod_Teste (
//Clocks
input CLOCK_27, CLOCK_50,
//Chaves e Botoes
input [3:0] KEY,
input [17:0] SW,
//Displays de 7 seg e LEDs
output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
output [8:0] LEDG,
output [17:0] LEDR,
//Serial
output UART_TXD,
input UART_RXD,
inout [7:0] LCD_DATA,
output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
//GPIO
inout [35:0] GPIO_0, GPIO_1
);
assign GPIO_1 = 36'hzzzzzzzzz;
assign GPIO_0 = 36'hzzzzzzzzz;
assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b1;
wire [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
LCD_TEST MyLCD (
.iCLK ( CLOCK_50 ),
.iRST_N ( KEY[0] ),
.d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
.d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
.LCD_DATA( LCD_DATA ),
.LCD_RW ( LCD_RW ),
.LCD_EN ( LCD_EN ),
.LCD_RS ( LCD_RS )
);

//---------- modifique a partir daqui --------

wire w_ULASrc, w_RegWrite, w_MemWrite, w_PCSrc, w_Zero, w_isBranch, w_Jump, w_Branch, w_AdderImmSrc;
wire [1:0] w_ImmSrc, w_ResultSrc;
wire [2:0] w_ULAControl;
wire [7:0]  w_PCp4, w_PC, w_PCn;
wire [31:0] w_Inst, w_rd1SrcA, w_rd2, w_SrcB, w_ULAResult, w_Wd3, w_Imm, w_RData, w_ImmPC, w_Adder2, w_DataIn, w_RegData, w_DataOut;
wire CLOCK_1, CLOCK_100;

//FreqDivider clock1hz(.clk_in(CLOCK_50), .clk_out(CLOCK_1));

//FreqDivider #(.OUTPUT_FREQUENCY(10)) clock100hz(.clk_in(CLOCK_50), .clk_out(CLOCK_100));

assign CLOCK_100 = CLOCK_50;

PC _pc(.clk(CLOCK_100), .rst(KEY[2]), .PCin(w_PCn), .PC(w_PC));

Adder adder4(.in0(w_PC), .in1(32'd4), .sum(w_PCp4));

InstructionMemory instMem(.A(w_PC), .RD(w_Inst));

registerFile regFile(.clk(CLOCK_100), .rst(KEY[2]), .ra1(w_Inst[19:15]), .rd1(w_rd1SrcA), .ra2(w_Inst[24:20]), .rd2(w_rd2),
							   .we3(w_RegWrite), .wa3(w_Inst[11:7]), .wd3(w_Wd3));


mux4x1 MuxImmSrc(.i0(w_Inst[31:20]),
								  .i1({w_Inst[31:25], w_Inst[11:7]}),
								  .i2({ w_Inst[7], w_Inst[30:25], w_Inst[11:8], 1'b0}),
								  .i3({{w_Inst[31]}, w_Inst[19:12], w_Inst[20], w_Inst[30:21], 1'b0}),
								  .sel(w_ImmSrc), .out(w_Imm));

mux2x1 MuxULASrc(.i0(w_rd2), .i1(w_Imm), .sel(w_ULASrc), .out(w_SrcB));

mux4x1 MuxResSrc(.i0(w_ULAResult), .i1(w_RegData), .i2(w_PCp4), .i3(0), .sel(w_ResultSrc), .out(w_Wd3));

mux2x1 MuxPCSrc(.i0(w_PCp4), .i1(w_ImmPC), .sel(w_PCSrc), .out(w_PCn));

mux2x1 MuxAdderImmSrc(.i0(w_rd1SrcA), .i1(w_PC), .sel(w_AdderImmSrc), .out(w_Adder2));

Adder adderimm(.in0(w_Imm), .in1(w_Adder2), .sum(w_ImmPC));

BranchController branchcotroller(.SrcA(w_rd1SrcA), .SrcB(w_rd2), .isBranch(w_isBranch), .Funct3(w_Inst[14:12]), .Branch(w_Branch));

ULA _ula(.SrcA(w_rd1SrcA), .SrcB(w_SrcB), .ULAControl(w_ULAControl), .ULAResult(w_ULAResult), .Z(w_Zero));

ControlUnit contUnit(.OP(w_Inst[6:0]), .Funct3(w_Inst[14:12]), .Funct7(w_Inst[31:25]),
								 .RegWrite(w_RegWrite), .ImmSrc(w_ImmSrc), .ULASrc(w_ULASrc),
								 .MemWrite(w_MemWrite), .ResultSrc(w_ResultSrc), .ULAControl(w_ULAControl),
								 .isBranch(w_isBranch), .Jump(w_Jump), .AdderImmSrc(w_AdderImmSrc));

dataMemory dataMem(.clk(CLOCK_100), .rst(KEY[2]), .WE(w_MemWrite), .A(w_ULAResult), .WD(w_rd2), .RD(w_RData));


ParallelIN parallelin(.MemData(w_RData), .Address(w_ULAResult), .DataIn(w_DataIn), .RegData(w_RegData));

ParallelOUT parallelout(.Address(w_ULAResult), .RegData(w_rd2), .EN(w_MemWrite), .clk(CLOCK_100), .rst(KEY[2]), .DataOut(w_DataOut));


assign w_PCSrc = w_Branch | w_Jump;

assign w_d0x4 = w_PC;
assign LEDR[0] = w_ResultSrc;
assign LEDR[1] = w_MemWrite;
assign LEDR[3:2] = w_ULAControl;
assign LEDR[4] = w_ULASrc;
assign LEDR[5] = w_ImmSrc;
assign LEDR[6] = w_RegWrite;


assign w_d1x4 = w_DataOut;
assign w_DataIn = SW[7:0];
assign LEDG[0] = w_DataOut;

hex_to_7seg _HEX0(.hex(w_Inst[3:0]), .seg(HEX0));
hex_to_7seg _HEX1(.hex(w_Inst[7:4]), .seg(HEX1));
hex_to_7seg _HEX2(.hex(w_Inst[11:8]), .seg(HEX2));
hex_to_7seg _HEX3(.hex(w_Inst[15:12]), .seg(HEX3));
hex_to_7seg _HEX4(.hex(w_Inst[19:16]), .seg(HEX4));
hex_to_7seg _HEX5(.hex(w_Inst[23:20]), .seg(HEX5));
hex_to_7seg _HEX6(.hex(w_Inst[27:24]), .seg(HEX6));
hex_to_7seg _HEX7(.hex(w_Inst[31:28]), .seg(HEX7));
endmodule









