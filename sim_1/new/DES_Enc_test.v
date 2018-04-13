`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/11 21:15:41
// Design Name: 
// Module Name: DES_Enc_test
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


module DES_Enc_test();

/************					*********************/
reg				clock, resetn;
reg[63:0]		plain;
reg				plain_en;
reg[63:0]		key;
wire[63:0]		cipher;
wire			cipher_rdy;

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
		plain <= 64'd0;
		plain_en <= 1'b0;
		key <= 64'd0;
	end
	else
	begin
		plain_en <= ~ plain_en;
		plain <= 64'h0001020304050607;
		key <= 64'h133457799BBCDFF1;
	end
end



/*******					******************/
DES_Enc	DUT(
    .clk		(clock),
    .rstn		(resetn),
    .plain		(plain),
    .plain_en	(plain_en),
    .key		(key),
    .cipher		(cipher),
    .cipher_rdy	(cipher_rdy)
    );

endmodule
