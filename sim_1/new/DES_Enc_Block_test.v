`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/13 19:07:44
// Design Name: 
// Module Name: DES_Enc_Block_test
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


module DES_Enc_Block_test();

/***********							***********************/
reg				clock, resetn;
reg[63:0]		plain;
reg				plain_en;
reg[63:0]		key;
wire[63:0]		cipher;
wire			cipher_rdy;

reg[7:0]		cnt, data;
/*************								********************/
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
		cnt <= 8'd0;
	else if(cnt == 8'd9)
		cnt <= 8'd0;
	else
		cnt <= cnt + 1;
end

always@(posedge clock)
begin
	if(~resetn)
	begin
		plain <= 64'd0;
		plain_en <= 1'b0;
		key <= 64'd0;
		data <= 8'd0;
	end
	else if(cnt == 8'd9)
	begin
		plain_en <= 1'b1;
		plain <= {data, data+8'd1, data+8'd2, data+8'd3, data+8'd4, data+8'd5, data+8'd6, data+8'd7};
		key <= 64'h133457799BBCDFF1;
		data <= data + 8'd8;
	end
	else
	begin
		plain_en <= 1'b0;
		plain <= 64'd0;
		// key <= 64'd0;
	end
end

/************					********************/
DES_Enc_Block	DUT(
    .clk			(clock),
    .rstn			(resetn),
    .plain			(plain),
    .plain_en		(plain_en),
    .key			(key),
    .mode			(3'b000), // 3'b000 -> ECB; 3'b001 -> CBC; 3'b010 -> CFB; 3'b011 -> OFB; 3'b100 -> CTR; 3'b101 -> GCM
    .iv				(64'd0),
    .iv_update		(1'b0),
    .padding		(3'd0), // 3'b000->None; 3'b001->Zeros; 3'b010->PKCS7; 3'b011->ANSIX923; 3'b100->ISO10126; 3'b101->1-0 padding
    .cipher			(cipher),
    .cipher_rdy		(cipher_rdy)
    );

endmodule
