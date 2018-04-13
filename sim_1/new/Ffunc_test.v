`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/11 13:25:24
// Design Name: 
// Module Name: Ffunc_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Ffunc_test();


/********					***********/
reg		clock, resetn;
wire[31:0]	dout;

/*********					**************/
initial
begin
	clock <= 1'b0;
	forever
	#5	clock <= ~clock;
end

initial
begin
	resetn <= 1'b0;
	#50 resetn <= 1'b1;
end

/************					********************/
Ffunction	DUT(
	.clk(clock),
	.rstn(resetn),
	.din(32'b1011_1110_1010_0110_1000_0000_0110_0110),
	.subkey(48'b0001_1011_0000_0010_1110_1111_1111_1100_0111_0000_0111_0010),
	.dout(dout)
);

endmodule
