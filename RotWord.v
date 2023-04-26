module RotWord (
	w0_curr,
	w0_next

);

input [31:0] w0_curr;
output [31:0] w0_next;

// wire [7:0] state_array[0:3][0:3]; this is how the state array should look ig

assign w0_next = {w0_curr[23:0],w0_curr[31:24]};

endmodule