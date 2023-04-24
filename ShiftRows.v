module ShiftRows (
	S0in, S1in, S2in, S3in,
	S0out, S1out, S2out, S3out
);

input [31:0] S0in, S1in, S2in, S3in;
output [31:0] S0out, S1out, S2out, S3out;

assign S0out = S0in;
assign S1out = {S1in[23:0],S1in[31:24]};
assign S2out = {S2in[15:0],S2in[31:16]};
assign S3out = {S3in[7:0],S3in[31:8]};

endmodule