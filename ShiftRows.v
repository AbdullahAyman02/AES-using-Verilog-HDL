module ShiftRows (
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

// wire [7:0] state_array[0:3][0:3]; this is how the state array should look ig

assign w0_next = {w0_curr[31-:8], w1_curr[23-:8], w2_curr[15-:8], w3_curr[7-:8]};
assign w1_next = {w1_curr[31-:8], w2_curr[23-:8], w3_curr[15-:8], w0_curr[7-:8]};
assign w2_next = {w2_curr[31-:8], w3_curr[23-:8], w0_curr[15-:8], w1_curr[7-:8]};
assign w3_next = {w3_curr[31-:8], w0_curr[23-:8], w1_curr[15-:8], w2_curr[7-:8]};

endmodule