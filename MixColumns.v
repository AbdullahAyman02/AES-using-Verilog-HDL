module MixColumns (
/*
	row1,
	row2,
	row3,
	row4,
	out_row1,
	out_row2,
	out_row3,
	out_row4
	*/
	in,
	out
);

function [7:0] mul2;
	input [7:0] x;
	begin
	mul2 = (x[7]) ? (x << 1) ^ 8'h1b : x << 1;
	end
endfunction

function [7:0] mul3;
	input [7:0] x;
	begin
	mul3 = mul2(x) ^ x;
	end
endfunction

/*
input [31:0] row1;
input [31:0] row2;
input [31:0] row3;
input [31:0] row4;

output [31:0] out_row1;
output [31:0] out_row2;
output [31:0] out_row3;
output [31:0] out_row4;
*/
input [127:0] in;
output [127:0] out;

genvar i;

generate
for (i=4;i>0;i = i - 1)
begin: mix_columns
	assign out[(32*i-1)-:8] = mul2(in[(32*i-1)-:8]) ^ mul3(in[(32*i-9)-:8]) ^ in[(32*i-17)-:8] ^ in[(32*i-25)-:8];
	assign out[(32*i-9)-:8] = in[(32*i-1)-:8] ^ mul2(in[(32*i-9)-:8]) ^ mul3(in[(32*i-17)-:8]) ^ in[(32*i-25)-:8];
	assign out[(32*i-17)-:8] = in[(32*i-1)-:8] ^ in[(32*i-9)-:8] ^ mul2(in[(32*i-17)-:8]) ^ mul3(in[(32*i-25)-:8]);
	assign out[(32*i-25)-:8] = mul3(in[(32*i-1)-:8]) ^ in[(32*i-9)-:8] ^ in[(32*i-17)-:8] ^ mul2(in[(32*i-25)-:8]);
end
endgenerate
endmodule