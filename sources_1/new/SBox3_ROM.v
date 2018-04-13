`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/10 19:19:28
// Design Name: 
// Module Name: SBox3_ROM
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


module SBox3_ROM(
    input clk,
	input rstn,
    input [3:0] col,
    input [1:0] row,
    output reg [3:0] dout
    );
	

/**************						***************/
reg[3:0]	ROM[63:0];
initial
	$readmemh("D:/Work/Cipher/Des/Code/FPGA/DES_EncDec/DES_EncDec.srcs/sources_1/Sbox/Sbox3.txt", ROM);
	
	
/*************						******************/

always@(posedge clk)
begin
	if(~rstn)
		dout <= 4'd0;
	else
		dout <= ROM[{row, col}];
end
	
endmodule
