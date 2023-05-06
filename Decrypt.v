module Decrypt(
	in,
	out,
	//Nr,
	key
);

input [127:0]in;
//input [3:0] Nr;
localparam Nr = 10;

localparam key_size = 4*(Nr+1)*32 - 1;

input [127:0]key;
output [127:0]out;

wire [key_size:0]w;

KeyExpansion key_expansion(key, w);

wire [127:0] sub_byte_out [Nr - 1 : 0];

wire [127:0] shift_rows_out [Nr - 1 : 0];

wire [127:0] mix_columns_out [Nr - 1 : 0];

wire [127:0] add_round_key_out [Nr : 0];

AddRoundKey add_round_key1(in, w[127:0],add_round_key_out[0]);
  
assign mix_columns_out[0][127:0] = add_round_key_out[0][127:0]; 

genvar i;
generate
for (i = 1; i < Nr; i = i + 1)
begin: decrypt
    InvShiftRows shift_rows1(mix_columns_out[i - 1][127:96], mix_columns_out[i - 1][95 :64], mix_columns_out[i - 1][63 :32], mix_columns_out[i - 1][31 : 0], shift_rows_out[i - 1][127:96], shift_rows_out[i - 1][95 :64], shift_rows_out[i - 1][63 :32], shift_rows_out[i - 1][31 : 0]);
    InvSubBytes sub_bytes1(shift_rows_out[i - 1], sub_byte_out[i - 1]);
    AddRoundKey add_round_key2(sub_byte_out[i - 1],w[((i+1)*128-1):((i+1)*128) - 128],add_round_key_out[i]);
    InvMixColumns mix_columns(add_round_key_out[i],mix_columns_out[i]);
end

InvShiftRows shift_rows2(mix_columns_out[Nr - 1][127:96], mix_columns_out[Nr - 1][95 :64], mix_columns_out[Nr - 1][63 :32], mix_columns_out[Nr - 1][31 : 0], shift_rows_out[Nr - 1][127:96], shift_rows_out[Nr - 1][95 :64], shift_rows_out[Nr - 1][63 :32], shift_rows_out[Nr - 1][31 : 0]);
InvSubBytes sub_bytes2(shift_rows_out[Nr - 1], sub_byte_out[Nr - 1]);
AddRoundKey add_round_key3(sub_byte_out[Nr - 1], w[key_size:key_size-127], add_round_key_out[Nr]);

assign out = add_round_key_out[Nr];

endgenerate
endmodule