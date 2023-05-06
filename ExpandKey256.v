module ExpandKey256 (
	rcon,
	w0_curr,
	w1_curr,
	w2_curr,
	w3_curr,
	w4_curr,
	w5_curr,
	w6_curr,
	w7_curr,
	w0_next,
	w1_next,
	w2_next,
	w3_next,
	w4_next,
	w5_next,
	w6_next,
	w7_next
);

input [31:0] rcon, w0_curr, w1_curr, w2_curr, w3_curr,w4_curr,w5_curr,w6_curr,w7_curr;
output [31:0] w0_next, w1_next, w2_next, w3_next,w4_next,w5_next,w6_next,w7_next;
wire [31:0] w0_sub,w1_sub,w2_sub,w3_sub,w0_sub1,w1_sub1,w2_sub1,w3_sub1,rcon,subWord,w7_beforeSub,w7_beforeRot,w3_afterSub,w3_beforeSub;
 
RotWord r (w7_beforeRot,w7_beforeSub);
SubBytes s({w7_beforeSub,w1_curr,w2_curr,w3_curr},{subWord,w1_sub,w2_sub,w3_sub});
SubBytes s1({w3_beforeSub,w1_curr,w2_curr,w3_curr},{w3_afterSub,w1_sub1,w2_sub1,w3_sub1});

assign w7_beforeRot = w7_curr;
assign w3_beforeSub = w3_next;

assign w0_next = w0_curr ^ subWord ^ rcon;
assign w1_next = w1_curr ^ w0_next;
assign w2_next = w2_curr ^ w1_next;
assign w3_next = w3_curr ^ w2_next;
assign w4_next = w4_curr ^ w3_afterSub;
assign w5_next = w5_curr ^ w4_next;
assign w6_next = w6_curr ^ w5_next;
assign w7_next = w7_curr ^ w6_next;

endmodule