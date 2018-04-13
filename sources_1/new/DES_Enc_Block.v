`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/13 13:02:25
// Design Name: 
// Module Name: DES_Enc_Block
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


module DES_Enc_Block(
    input clk,
    input rstn,
    input [63:0] plain,
    input plain_en,
    input [63:0] key,
    input [2:0] mode, // 3'b000 -> ECB; 3'b001 -> CBC; 3'b010 -> CFB; 3'b011 -> OFB; 3'b100 -> CTR; 3'b101 -> GCM
    input [63:0] iv,
    input iv_update,
    input [2:0] padding, // 3'b000->None; 3'b001->Zeros; 3'b010->PKCS7; 3'b011->ANSIX923; 3'b100->ISO10126; 3'b101->1-0 padding
    output [63:0] cipher,
    output cipher_rdy
    );
	
/************						************************/




/***************					***************************/

	


/***************					***************************/
DES_Enc	DES_Enc(
    .clk		(clk),
    .rstn		(rstn),
    .plain		(plain),
    .plain_en	(plain_en),
    .key		(key),
    .cipher		(cipher),
    .cipher_rdy	(cipher_rdy)
    );	
	
endmodule
