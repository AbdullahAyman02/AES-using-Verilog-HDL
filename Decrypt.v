module Decrypt #(parameter Nk=8,parameter Nr=14,parameter Nb = 4)(
	rst,
    clk,
    cs,
    miso,
    mosi
);

input rst, clk, cs, miso;
output mosi;
wire [127:0]in;
reg [127:0]out;
wire [Nk*32-1:0]key;

localparam key_size = 1919;

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
wire [1407:0]w1;
wire [1663:0]w2;
wire [1919:0]w3;

reg [127:0] buffer;
integer round = Nr;
wire [255:0]key_to_expand;

assign key_to_expand = (Nk == 4) ? {{(128){1'b0}},key} : (Nk == 6) ? {{(64){1'b0}},key} : key;

KeyExpansion key_expansion(key_to_expand[127:0], w1);
KeyExpansion192 key_expansion192(key_to_expand[191:0], w2);
KeyExpansion256 key_expansion256(key_to_expand[255:0], w3);


wire [127:0] w_round;

assign w_round = (round == 0) ? w[key_size: key_size - 127]:
					 (round == 1) ? w[key_size - 128: key_size - 255]:
					 (round == 2) ? w[key_size - 256: key_size - 383]:
					 (round == 3) ? w[key_size - 384: key_size - 511]:
					 (round == 4) ? w[key_size - 512: key_size - 639]:
					 (round == 5) ? w[key_size - 640: key_size - 767]:
					 (round == 6) ? w[key_size - 768: key_size - 895]:
					 (round == 7) ? w[key_size - 896: key_size - 1023]:
					 (round == 8) ? w[key_size - 1024: key_size - 1151]:
					 (round == 9) ? w[key_size - 1152: key_size - 1279]:
					 (round == 10) ? w[key_size - 1280: key_size - 1407]:
					 (round == 11) ? w[key_size - 1408: key_size - 1535]:
					 (round == 12) ? w[key_size - 1536: key_size - 1663]:
					 (round == 13) ? w[key_size - 1664: key_size - 1791]:
					 w[key_size - 1792: key_size - 1919];

assign w = Nk == 4 ? {w1,{(512){1'b0}}} : Nk == 6 ? {w2,{(256){1'b0}}} : w3;

wire [127:0] sub_byte_out, sub_byte_out_last;

wire [127:0] shift_rows_out, shift_rows_out_last;

wire [127:0] mix_columns_out;

wire [127:0] add_round_key_out;

reg [127:0] inround;
wire [127:0] outfirst, outround, outroundlast;

AddRoundKey add_round_key1(in, w_round,outfirst);

InvShiftRows shift_rows1(inround[127:96], inround[95 :64], inround[63 :32], inround[31 : 0], shift_rows_out[127:96], shift_rows_out[95 :64], shift_rows_out[63 :32], shift_rows_out[31 : 0]);
InvSubBytes sub_bytes1(shift_rows_out, sub_byte_out);
AddRoundKey add_round_key2(sub_byte_out,w_round,add_round_key_out);
InvMixColumns mix_columns(add_round_key_out, outround);

always@( posedge clk)
begin
	inround = buffer;
	if(round == 0)
	begin
		out = outroundlast;
		round = round - 1;
	end
	else if (rst)
		round = Nr;
	else if(round >= 0 && ready)
		round = round - 1;
end

always@( negedge clk)
begin

	if(round == Nr)
		buffer = outfirst;
	else if (!rst)
		buffer = outround;
end

InvShiftRows shift_rows2(inround[127:96], inround[95 :64], inround[63 :32], inround[31 : 0], shift_rows_out_last[127:96], shift_rows_out_last[95 :64], shift_rows_out_last[63 :32], shift_rows_out_last[31 : 0]);
InvSubBytes sub_bytes2(shift_rows_out_last, sub_byte_out_last);
AddRoundKey add_round_key3(sub_byte_out_last, w[1919:1919-127], outroundlast);

endmodule