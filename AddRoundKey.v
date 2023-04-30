module AddRoundKey (
	/*w0_curr,
	w1_curr,
	w2_curr,
	w3_curr,
	k0_curr,
	k1_curr,
	k2_curr,
	k3_curr,
	w0_next,
	w1_next,
	w2_next,
	w3_next*/
	addrk_in,
	addrk_key,
	addrk_out
);

//input [31:0] w0_curr, w1_curr, w2_curr, w3_curr, k0_curr, k1_curr, k2_curr, k3_curr;
//output [31:0] w0_next, w1_next, w2_next, w3_next;
input  [127:0]addrk_in;
input  [127:0]addrk_key;
output [127:0]addrk_out;

//assign w0_next = w0_curr ^ k0_curr;
//assign w1_next = w1_curr ^ k1_curr;
//assign w2_next = w2_curr ^ k2_curr;
//assign w3_next = w3_curr ^ k3_curr;
assign addrk_out = addrk_in ^ addrk_key;

endmodule