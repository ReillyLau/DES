`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/11 19:28:07
// Design Name: 
// Module Name: Rfunction_test
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


module Rfunction_test();

/************					*********************/
reg				clock, resetn;
reg[63:0]		din;
reg				din_en;
wire[63:0]		dout;
wire			dout_rdy;

/************					*******************/
initial
begin
	clock <= 1'b0;
	forever
	#5	clock <= ~ clock;
end

initial
begin
	resetn <= 1'b0;
	#50 resetn <= 1'b1;
end

always@(posedge clock)
begin
	if(~resetn)
	begin
		din <= 64'd0;
		din_en <= 1'b0;
	end
	else
	begin
		din_en <= ~ din_en;
		din <= 64'b0000_0000_0000_0000_1111_0000_1010_1010_0000_0000_0000_0000_0000_0000_1100_1100;
	end
end




Rfunction	DUT(
	.clk		(clock),
	.rstn		(resetn),
	.subkey		(48'b0001_1011_0000_0010_1110_1111_1111_1100_0111_0000_0111_0010),
	.din		(din),
	.din_en		(din_en),
	.dout		(dout),
	.dout_rdy	(dout_rdy)
);
	
endmodule
