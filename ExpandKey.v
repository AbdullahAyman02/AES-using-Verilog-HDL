module ExpandKey (
	iteration,
	w0_curr,
	w1_curr,
	w2_curr,
	w3_curr,
	w0_next,
	w1_next,
	w2_next,
	w3_next
);

input [31:0] w0_curr, w1_curr, w2_curr, w3_curr;
output [31:0] w0_next, w1_next, w2_next, w3_next;
input [5:0] iteration ;
wire [31:0] w0_sub,w1_sub,w2_sub,w3_sub,rcon,subWord,w3_beforeSub,w3_beforeRot;
 
RotWord r (w3_beforeRot,w3_beforeSub);
SubBytes s(w3_beforeSub,w1_curr,w2_curr,w3_curr,subWord,w1_sub,w2_sub,w3_sub);


assign w3_beforeRot = w3_curr;
 assign rcon = {(2**iteration),24'b0};
 assign w0_next = w0_curr ^ subWord ^ rcon;
 assign w1_next = w1_curr ^ w0_next;
 assign w2_next = w2_curr ^ w1_next;
 assign w3_next = w3_curr ^ w2_next;

endmodule