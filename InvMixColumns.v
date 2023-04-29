module InvMixColumns (
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

function [7:0] mul2(input [7:0] x,input integer number);
	integer i;
	begin
	for(i = 0;i<number;i = i + 1)
	begin
		x = (x[7]) ? ((x << 1) ^ 8'h1b) : x << 1;
	end
	mul2 = x;
	end
endfunction

function [7:0] mul9;
	input [7:0] x;
	begin
	mul9 = mul2(x,3) ^ x;
	end
endfunction

function [7:0] mulb;
	input [7:0] x;
	begin
	mulb = mul2(x,3) ^ mul2(x,1) ^ x;
	end
endfunction

function [7:0] muld;
input [7:0] x;
	begin
	muld = mul2(x,3) ^ mul2(x,2) ^ x;
	end
endfunction

function [7:0] mule;
input [7:0] x;
	begin
	mule = mul2(x,3) ^ mul2(x,2) ^ mul2(x,1);
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
begin: inv_mix_columns
	assign out[(32*i-1)-:8] = mule(in[(32*i-1)-:8]) ^ mulb(in[(32*i-9)-:8]) ^ muld(in[(32*i-17)-:8]) ^ mul9(in[(32*i-25)-:8]);
	assign out[(32*i-9)-:8] = mul9(in[(32*i-1)-:8]) ^ mule(in[(32*i-9)-:8]) ^ mulb(in[(32*i-17)-:8]) ^ muld(in[(32*i-25)-:8]);
	assign out[(32*i-17)-:8] = muld(in[(32*i-1)-:8]) ^ mul9(in[(32*i-9)-:8]) ^ mule(in[(32*i-17)-:8]) ^ mulb(in[(32*i-25)-:8]);
	assign out[(32*i-25)-:8] = mulb(in[(32*i-1)-:8]) ^ muld(in[(32*i-9)-:8]) ^ mul9(in[(32*i-17)-:8]) ^ mule(in[(32*i-25)-:8]);
end
endgenerate
endmodule