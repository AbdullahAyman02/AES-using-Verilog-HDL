module Encrypt(
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

wire [127:0] mix_columns_out [Nr - 2 : 0];

wire [127:0] add_round_key_out [Nr : 0];

AddRoundKey add_round_key1(in, w[key_size:key_size - 127],add_round_key_out[0]);
  
genvar i;
generate
for (i = 1; i < Nr; i = i + 1)
begin: encrypt
    SubBytes sub_bytes1(add_round_key_out[i - 1], sub_byte_out[i - 1]);
    ShiftRows shift_rows1(sub_byte_out[i - 1][127:96], sub_byte_out[i - 1][95 :64], sub_byte_out[i - 1][63 :32], sub_byte_out[i - 1][31 : 0], shift_rows_out[i - 1][127:96], shift_rows_out[i - 1][95 :64], shift_rows_out[i - 1][63 :32], shift_rows_out[i - 1][31 : 0]);
    MixColumns mix_columns(shift_rows_out[i - 1],mix_columns_out[i - 1]);
    AddRoundKey add_round_key2(mix_columns_out[i - 1],w[key_size - (i*128):key_size - (i*128) - 127],add_round_key_out[i]);
end

SubBytes sub_bytes2(add_round_key_out[Nr - 1], sub_byte_out[Nr - 1]);
ShiftRows shift_rows2(sub_byte_out[Nr - 1][127:96], sub_byte_out[Nr - 1][95 :64], sub_byte_out[Nr - 1][63 :32], sub_byte_out[Nr - 1][31 : 0], shift_rows_out[Nr - 1][127:96], shift_rows_out[Nr - 1][95 :64], shift_rows_out[Nr - 1][63 :32], shift_rows_out[Nr - 1][31 : 0]);
AddRoundKey add_round_key3(shift_rows_out[Nr - 1], w[127:0], add_round_key_out[Nr]);

assign out = add_round_key_out[Nr];

endgenerate
endmodule