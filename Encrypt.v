module Encrypt #(parameter Nk=8,parameter Nr=14,parameter Nb = 4)(
	rst,
    clk,
    cs,
    miso,
    mosi,
	 finished
);

input rst, clk, cs, miso;
output mosi;
output reg finished = 1'b0;

wire [127:0]in;
reg [127:0]out;
wire [Nk*32-1:0]key;

localparam key_size = 4*(Nr+1)*32 - 1;

SPI #(Nk) serial(
    rst,
    clk,
    cs,
    miso,
    key,
    in,
	mosi,
    out, 
	 ready
);

wire [1919:0]w;

reg [127:0] buffer;
integer round = 0;
wire [key_size:0]w_expand;
integer counterExpand;

wire rstExpand;
assign rstExpand = rst || (ready && !counterExpand);

GeneralKeyExpansion #(.Nk(Nk), .Nr(Nr)) key_expand(
	.key(key),
	.out(w_expand),
	.clk(clk),
	.rst(rstExpand)
);

wire [127:0] w_round;

assign w_round = (round == 0) ? w[1919: 1919 - 127]:
					 (round == 1) ? w[1919 - 128: 1919 - 255]:
					 (round == 2) ? w[1919 - 256: 1919 - 383]:
					 (round == 3) ? w[1919 - 384: 1919 - 511]:
					 (round == 4) ? w[1919 - 512: 1919 - 639]:
					 (round == 5) ? w[1919 - 640: 1919 - 767]:
					 (round == 6) ? w[1919 - 768: 1919 - 895]:
					 (round == 7) ? w[1919 - 896: 1919 - 1023]:
					 (round == 8) ? w[1919 - 1024: 1919 - 1151]:
					 (round == 9) ? w[1919 - 1152: 1919 - 1279]:
					 (round == 10) ? w[1919 - 1280: 1919 - 1407]:
					 (round == 11) ? w[1919 - 1408: 1919 - 1535]:
					 (round == 12) ? w[1919 - 1536: 1919 - 1663]:
					 (round == 13) ? w[1919 - 1664: 1919 - 1791]:
					 w[1919 - 1792: 1919 - 1919];
								 
assign w = (Nk == 4) ? {w_expand,{(512){1'b0}}} : (Nk == 6) ? {w_expand,{(256){1'b0}}} : w_expand;

wire [127:0] sub_byte_out, sub_byte_out_last;

wire [127:0] shift_rows_out, shift_rows_out_last;

wire [127:0] mix_columns_out;

wire [127:0] add_round_key_out;

reg [127:0] inround;
wire [127:0] outfirst, outround, outroundlast;

AddRoundKey add_round_key1(in, w[1919: 1919 - 127], outfirst);
  
SubBytes sub_bytes1(inround, sub_byte_out);
ShiftRows shift_rows1(sub_byte_out[127:96], sub_byte_out[95 :64], sub_byte_out[63 :32], sub_byte_out[31 : 0], shift_rows_out[127:96], shift_rows_out[95 :64], shift_rows_out[63 :32], shift_rows_out[31 : 0]);
MixColumns mix_columns(shift_rows_out,mix_columns_out);
AddRoundKey add_round_key2(mix_columns_out, w_round, outround);

always@( posedge clk)
begin
	inround = buffer;
	if(rst)
	begin
		round = 0;
		finished = 1'b0;
		counterExpand = 1'b0;
	end
	else if (counterExpand < 15 && ready)
		counterExpand = counterExpand + 1;
	else if(round < Nr && ready)
		round = round + 1;
	else if(round == Nr && ready)
	begin
		out = outroundlast;
		round = round + 1;
		finished = 1'b1;
		round = 0;
	end
  else if(cs && finished)
		finished = 1'b0;
	
end

always@( negedge clk)
begin

	if(round == 0)
		buffer = outfirst;
	else if (!rst)
		buffer = outround;
end

SubBytes sub_bytes2(inround, sub_byte_out_last);
ShiftRows shift_rows2(sub_byte_out_last[127:96], sub_byte_out_last[95 :64], sub_byte_out_last[63 :32], sub_byte_out_last[31 : 0], shift_rows_out_last[127:96], shift_rows_out_last[95 :64], shift_rows_out_last[63 :32], shift_rows_out_last[31 : 0]);
AddRoundKey add_round_key3(shift_rows_out_last, w_round, outroundlast);

endmodule