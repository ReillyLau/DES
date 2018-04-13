`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/10 19:16:46
// Design Name: 
// Module Name: Ffunction
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


module Ffunction(
    input clk,
    input rstn,
    input [31:0] din,
	input [47:0] subkey,
    output [31:0] dout
    );
	
/***********							**********/

wire[47:0]		din_e;		//输入信号扩展置换之后的信号
wire[31:0]		rd;

reg[47:0]		din_key;

/*****************		置换				************/
//	扩展置换
assign din_e = {din[0], din[31:27], din[28:23], din[24:19], din[20:15], din[16:11], din[12:7], din[8:3], din[4:0], din[31]};

//	输出置换
assign dout = {rd[16], rd[25], rd[12], rd[11], rd[3], rd[20], rd[4], rd[15], rd[31], rd[17], rd[9], rd[6], rd[27], rd[14], rd[1], rd[22], rd[30], rd[24], rd[8], rd[18], rd[0], rd[5], rd[29], rd[23], rd[13], rd[19], rd[2], rd[26], rd[10], rd[21], rd[28], rd[7]};
	

/**********			异或子秘钥			************************/
always@(posedge clk)
begin
	if(~rstn)
		din_key <= 48'd0;
	else
		din_key <= din_e ^ subkey;
end


/***************			S盒例化				*****************/

SBox1_ROM	SBOX1(
	.clk		(clk),
	.rstn		(rstn),
	.col		(din_key[46:43]),
	.row		({din_key[47], din_key[42]}),
	.dout		(rd[31:28])
);

SBox2_ROM	SBOX2(
	.clk		(clk),
	.rstn		(rstn),
	.col		(din_key[40:37]),
	.row		({din_key[41], din_key[36]}),
	.dout		(rd[27:24])
);	

SBox3_ROM	SBOX3(
	.clk		(clk),
	.rstn		(rstn),
	.col		(din_key[34:31]),
	.row		({din_key[35], din_key[30]}),
	.dout		(rd[23:20])
);

SBox4_ROM	SBOX4(
	.clk		(clk),
	.rstn		(rstn),
	.col		(din_key[28:25]),
	.row		({din_key[29], din_key[24]}),
	.dout		(rd[19:16])
);

SBox5_ROM	SBOX5(
	.clk		(clk),
	.rstn		(rstn),
	.col		(din_key[22:19]),
	.row		({din_key[23], din_key[18]}),
	.dout		(rd[15:12])
);

SBox6_ROM	SBOX6(
	.clk		(clk),
	.rstn		(rstn),
	.col		(din_key[16:13]),
	.row		({din_key[17], din_key[12]}),
	.dout		(rd[11:8])
);

SBox7_ROM	SBOX7(
	.clk		(clk),
	.rstn		(rstn),
	.col		(din_key[10:7]),
	.row		({din_key[11], din_key[6]}),
	.dout		(rd[7:4])
);

SBox8_ROM	SBOX8(
	.clk		(clk),
	.rstn		(rstn),
	.col		(din_key[4:1]),
	.row		({din_key[5], din_key[0]}),
	.dout		(rd[3:0])
);
endmodule
