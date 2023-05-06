//-----------------------------------------------------
/*
Author: Abdullah Ayman
*/
//-----------------------------------------------------
module InvSubBytes (
    Inv_State_curr,
    Inv_State_next
);

input  [127:0]Inv_State_curr;
output [127:0]Inv_State_next;

wire [127:0]Inv_State_curr;
wire [127:0]Inv_State_next;

genvar i;
generate
for(i = 0; i < 128; i = i + 8) 
begin : inv_sub_bytes
    InvSBox invsbox(Inv_State_curr[i +: 8], Inv_State_next[i +: 8]);
end
endgenerate

endmodule