`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/11 19:02:25
// Design Name: 
// Module Name: Rfunction
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


module Rfunction(
    input clk,
    input rstn,
    input [47:0] subkey,
    input [63:0] din,
	input		 din_en,
    output [63:0] dout,
	output		 dout_rdy
    );

/*************				**************/
	
wire[31:0]		fdout;
reg[31:0]		sum;
reg[63:0]		din_r1, din_r2, din_r3;
reg				din_en_r1, din_en_r2, din_en_r3;
/*************				*************/
assign dout = {din_r3[31:0], sum};	// 轮函数输出与输入相比延迟3个时钟周期
assign dout_rdy = din_en_r3;

/***********				*************/

always@(posedge clk)
begin
	if(~rstn)
	begin
		din_r1 <= 64'd0;
		din_r2 <= 64'd0;
		din_r3 <= 64'd0;
		{din_en_r3, din_en_r2, din_en_r1} <= 3'b000;
	end
	else
	begin
		din_r1 <= din;
		din_r2 <= din_r1;
		din_r3 <= din_r2;
		{din_en_r3, din_en_r2, din_en_r1} <= {din_en_r2, din_en_r1, din_en};
	end
end


always@(posedge clk)
begin
	if(~rstn)
		sum <= 32'd0;
	else
		sum <= fdout ^ din_r2[63:32];	//Ffunction输出与输入相比延迟2个时钟周期
end
	
// Ffunction的输出比输入延迟2个时钟周期
Ffunction	Ffunction_inst(
	.clk(clk),
	.rstn(rstn),
	.din(din[31:0]),
	.subkey(subkey),
	.dout(fdout)
);

	
	
	
	
endmodule
