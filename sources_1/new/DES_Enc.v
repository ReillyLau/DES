`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/11 20:32:54
// Design Name: 
// Module Name: DES_Enc
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


module DES_Enc(
    input clk,
    input rstn,
    input [63:0] plain,
    input plain_en,
    input [63:0] key,
    output [63:0] cipher,
    output cipher_rdy
    );
	
wire[47:0]	subkey1, subkey2, subkey3, subkey4, subkey5, subkey6, subkey7, subkey8, subkey9, subkey10;
wire[47:0]	subkey11, subkey12, subkey13, subkey14, subkey15, subkey16;
wire[63:0]	dout_r1, dout_r2, dout_r3, dout_r4, dout_r5, dout_r6, dout_r7, dout_r8, dout_r9, dout_r10;
wire[63:0]	dout_r11, dout_r12, dout_r13, dout_r14, dout_r15, dout_r16;
wire dout_rdy_r1, dout_rdy_r2, dout_rdy_r3, dout_rdy_r4, dout_rdy_r5, dout_rdy_r6, dout_rdy_r7, dout_rdy_r8;
wire dout_rdy_r9, dout_rdy_r10, dout_rdy_r11, dout_rdy_r12, dout_rdy_r13, dout_rdy_r14, dout_rdy_r15, dout_rdy_r16;

wire[63:0] din_IP;
wire[63:0]	dout;

/***************		初始置换IP			*********************/
assign din_IP = {plain[6], plain[14], plain[22], plain[30], plain[38], plain[46], plain[54], plain[62], plain[4], plain[12], plain[20], plain[28], plain[36], plain[44], plain[52], plain[60], plain[2], plain[10], plain[18], plain[26], plain[34], plain[42], plain[50], plain[58], plain[0], plain[8], plain[16], plain[24], plain[32], plain[40], plain[48], plain[56], plain[7], plain[15], plain[23], plain[31], plain[39], plain[47], plain[55], plain[63], plain[5], plain[13], plain[21], plain[29], plain[37], plain[45], plain[53], plain[61], plain[3], plain[11], plain[19], plain[27], plain[35], plain[43], plain[51], plain[59], plain[1], plain[9], plain[17], plain[25], plain[33], plain[41], plain[49], plain[57]};

	
/****************		逆初始置换				***********************/
assign cipher = {dout[24], dout[56], dout[16], dout[48], dout[8], dout[40], dout[0], dout[32], dout[25], dout[57], dout[17], dout[49], dout[9], dout[41], dout[1], dout[33], dout[26], dout[58], dout[18], dout[50], dout[10], dout[42], dout[2], dout[34], dout[27], dout[59], dout[19], dout[51], dout[11], dout[43], dout[3], dout[35], dout[28], dout[60], dout[20], dout[52], dout[12], dout[44], dout[4], dout[36], dout[29], dout[61], dout[21], dout[53], dout[13], dout[45], dout[5], dout[37], dout[30], dout[62], dout[22], dout[54], dout[14], dout[46], dout[6], dout[38], dout[31], dout[63], dout[23], dout[55], dout[15], dout[47], dout[7], dout[39]};

assign cipher_rdy = dout_rdy_r16;
assign dout = {dout_r16[31:0], dout_r16[63:32]};
	
/***********	轮函数					*******************/
key_sched	key_shedule(
    .key			(key),
    .subkey1		(subkey1),
    .subkey2		(subkey2),
    .subkey3		(subkey3),
    .subkey4		(subkey4),
    .subkey5		(subkey5),
    .subkey6		(subkey6),
    .subkey7		(subkey7),
    .subkey8		(subkey8),
    .subkey9		(subkey9),
    .subkey10		(subkey10),
    .subkey11		(subkey11),
    .subkey12		(subkey12),
    .subkey13		(subkey13),
    .subkey14		(subkey14),
    .subkey15		(subkey15),
    .subkey16		(subkey16)
    );
	
	
Rfunction	r1(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey1),
	.din		(din_IP),
	.din_en		(plain_en),
	.dout		(dout_r1),
	.dout_rdy	(dout_rdy_r1)
);
	
Rfunction	r2(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey2),
	.din		(dout_r1),
	.din_en		(dout_rdy_r1),
	.dout		(dout_r2),
	.dout_rdy	(dout_rdy_r2)
);	

Rfunction	r3(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey3),
	.din		(dout_r2),
	.din_en		(dout_rdy_r2),
	.dout		(dout_r3),
	.dout_rdy	(dout_rdy_r3)
);		
	
Rfunction	r4(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey4),
	.din		(dout_r3),
	.din_en		(dout_rdy_r3),
	.dout		(dout_r4),
	.dout_rdy	(dout_rdy_r4)
);	
	
Rfunction	r5(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey5),
	.din		(dout_r4),
	.din_en		(dout_rdy_r4),
	.dout		(dout_r5),
	.dout_rdy	(dout_rdy_r5)
);	
	
Rfunction	r6(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey6),
	.din		(dout_r5),
	.din_en		(dout_rdy_r5),
	.dout		(dout_r6),
	.dout_rdy	(dout_rdy_r6)
);	
	
Rfunction	r7(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey7),
	.din		(dout_r6),
	.din_en		(dout_rdy_r6),
	.dout		(dout_r7),
	.dout_rdy	(dout_rdy_r7)
);	
	
Rfunction	r8(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey8),
	.din		(dout_r7),
	.din_en		(dout_rdy_r7),
	.dout		(dout_r8),
	.dout_rdy	(dout_rdy_r8)
);	
	
Rfunction	r9(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey9),
	.din		(dout_r8),
	.din_en		(dout_rdy_r8),
	.dout		(dout_r9),
	.dout_rdy	(dout_rdy_r9)
);	
	
Rfunction	r10(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey10),
	.din		(dout_r9),
	.din_en		(dout_rdy_r9),
	.dout		(dout_r10),
	.dout_rdy	(dout_rdy_r10)
);	
	
Rfunction	r11(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey11),
	.din		(dout_r10),
	.din_en		(dout_rdy_r10),
	.dout		(dout_r11),
	.dout_rdy	(dout_rdy_r11)
);	
	
Rfunction	r12(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey12),
	.din		(dout_r11),
	.din_en		(dout_rdy_r11),
	.dout		(dout_r12),
	.dout_rdy	(dout_rdy_r12)
);	
	
Rfunction	r13(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey13),
	.din		(dout_r12),
	.din_en		(dout_rdy_r12),
	.dout		(dout_r13),
	.dout_rdy	(dout_rdy_r13)
);	
	
Rfunction	r14(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey14),
	.din		(dout_r13),
	.din_en		(dout_rdy_r13),
	.dout		(dout_r14),
	.dout_rdy	(dout_rdy_r14)
);	
	
Rfunction	r15(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey15),
	.din		(dout_r14),
	.din_en		(dout_rdy_r14),
	.dout		(dout_r15),
	.dout_rdy	(dout_rdy_r15)
);	
	
Rfunction	r16(
	.clk		(clk),
	.rstn		(rstn),
	.subkey		(subkey16),
	.din		(dout_r15),
	.din_en		(dout_rdy_r15),
	.dout		(dout_r16),
	.dout_rdy	(dout_rdy_r16)
);	
	
endmodule
