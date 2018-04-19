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
parameter		BLOCK_CNT = 2**20;


reg				clock, resetn;
reg[63:0]		plain;
reg				plain_en;
reg[63:0]		key;
wire[63:0]		cipher;
wire			cipher_rdy;
reg[31:0]		cnt;

integer data_file, i;
integer result_file;
/************					*******************/
initial
	data_file = $fopen("D:/Work/Cipher/Des/Data/rand_64bit.dat", "rb");

initial
	result_file = $fopen("D:/Work/Cipher/Des/Data/rand_64bit_Dec_ECB.dat", "wb");


/************					******************/
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
		cnt <= 32'd0;
	end
	else
	begin
		if(cnt < BLOCK_CNT)
		begin
			plain_en <= 1'b1;
			// plain <= 64'h0001020304050607;
			i = $fread(plain, data_file);
			key <= 64'h133457799BBCDFF1;
			cnt <= cnt + 1;
		end
		else
			plain_en <= 1'b0;
			
	end
end

always@(posedge clock)
begin
	if(cipher_rdy)
		$fwrite(result_file, "%u", {cipher[39:32], cipher[47:40], cipher[55:48], cipher[63:56], cipher[7:0], cipher[15:8], cipher[23:16], cipher[31:24]});
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
