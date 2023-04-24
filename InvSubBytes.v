//-----------------------------------------------------
/*
Author: Abdullah Ayman
*/
//-----------------------------------------------------
module InvSubBytes (
//    Inv_State_curr,
//    Inv_State_next
    inv_w0_curr,
    inv_w1_curr,
    inv_w2_curr,
    inv_w3_curr,
    inv_w0_next,
    inv_w1_next,
    inv_w2_next,
    inv_w3_next
);

//input  [127:0]Inv_State_curr;
input  [31:0]inv_w0_curr;
input  [31:0]inv_w1_curr;
input  [31:0]inv_w2_curr;
input  [31:0]inv_w3_curr;
//output [127:0]Inv_State_next;
output [31:0]inv_w0_next;
output [31:0]inv_w1_next;
output [31:0]inv_w2_next;
output [31:0]inv_w3_next;

wire [127:0]Inv_State_curr;
wire [127:0]Inv_State_next;

assign Inv_State_curr[127:96] = inv_w0_curr;
assign Inv_State_curr[95 :64] = inv_w1_curr;
assign Inv_State_curr[63 :32] = inv_w2_curr;
assign Inv_State_curr[31 : 0] = inv_w3_curr;

genvar i;
generate
for(i = 0; i < 128; i = i + 8) 
begin : inv_sub_bytes
    InvSBox invsbox(Inv_State_curr[i +: 8], Inv_State_next[i +: 8]);
end
endgenerate

assign inv_w0_next = Inv_State_next[127:96];
assign inv_w1_next = Inv_State_next[95 :64];
assign inv_w2_next = Inv_State_next[63 :32];
assign inv_w3_next = Inv_State_next[31 : 0];

endmodule