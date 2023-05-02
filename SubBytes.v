//-----------------------------------------------------
/*
Author: Abdullah Ayman
*/
//-----------------------------------------------------
module SubBytes (
    State_curr,
    State_next
/*    w0_curr,
    w1_curr,
    w2_curr,
    w3_curr,
    w0_next,
    w1_next,
    w2_next,
    w3_next*/
);

input  [127:0]State_curr;
//input  [31:0]w0_curr;
//input  [31:0]w1_curr;
//input  [31:0]w2_curr;
//input  [31:0]w3_curr;
output [127:0]State_next;
//output [31:0]w0_next;
//output [31:0]w1_next;
//output [31:0]w2_next;
//output [31:0]w3_next;

wire [127:0]State_curr;
wire [127:0]State_next;

//assign State_curr[127:96] = w0_curr;
//assign State_curr[95 :64] = w1_curr;
//assign State_curr[63 :32] = w2_curr;
//assign State_curr[31 : 0] = w3_curr;

genvar i;
generate
for(i = 0; i < 128; i = i + 8) 
begin : sub_bytes
    SBox sbox(State_curr[i +: 8], State_next[i +: 8]);
end
endgenerate

//assign w0_next = State_next[127:96];
//assign w1_next = State_next[95 :64];
//assign w2_next = State_next[63 :32];
//assign w3_next = State_next[31 : 0];

endmodule