module Encrypt #(parameter Nk=4,parameter Nr=10,parameter Nb = 4)(
	in,
	out,
	key
);

input [127:0]in;

localparam key_size = Nb*(Nr+1)*32 - 1;

input [255:0]key;

output [127:0]out;

wire [key_size:0]w;
wire [1407:0]w1;
wire [1663:0]w2;
wire [1919:0]w3;

KeyExpansion key_expansion(key[127:0], w1);
KeyExpansion192 key_expansion192(key[191:0], w2);
KeyExpansion256 key_expansion256(key[255:0], w3);

assign w = Nk == 4 ? w1 : Nk == 6 ? w2 : w3;

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