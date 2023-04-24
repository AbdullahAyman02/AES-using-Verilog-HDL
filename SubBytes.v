module SubBytes (
    State_curr,
    State_next
);
input  [127:0]State_curr;
output [127:0]State_next;

genvar i;
generate
for(i = 0; i < 128; i = i + 8) 
begin : sub_bytes
    SBox sbox(State_curr[i +: 8], State_next[i +: 8]);
end
endgenerate

endmodule