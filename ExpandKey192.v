module ExpandKey192 (
	rcon,
	w0_curr,
	w1_curr,
	w2_curr,
	w3_curr,
	w4_curr,
	w5_curr,
	w0_next,
	w1_next,
	w2_next,
	w3_next,
	w4_next,
	w5_next
);

input [31:0] rcon, w0_curr, w1_curr, w2_curr, w3_curr,w4_curr,w5_curr;
output [31:0] w0_next, w1_next, w2_next, w3_next,w4_next,w5_next;
wire [31:0] w0_sub,w1_sub,w2_sub,w3_sub,rcon,subWord,w5_beforeSub,w5_beforeRot;
 
RotWord r (w5_beforeRot,w5_beforeSub);
SubBytes s({w5_beforeSub,w1_curr,w2_curr,w3_curr},{subWord,w1_sub,w2_sub,w3_sub});

assign w5_beforeRot = w5_curr;

assign w0_next = w0_curr ^ subWord ^ rcon;
assign w1_next = w1_curr ^ w0_next;
assign w2_next = w2_curr ^ w1_next;
assign w3_next = w3_curr ^ w2_next;
assign w4_next = w4_curr ^ w3_next;
assign w5_next = w5_curr ^ w4_next;

endmodule