module generalExpandKey #(parameter Nk=4) (
	rcon,
	w_curr,
	w_next
	
);

input [32*Nk - 1 :0] w_curr;
input [32:0] rcon;
output reg [32*Nk - 1:0] w_next;
wire [31:0] w0_sub,w1_sub,w2_sub,w3_sub,w0_sub1,w1_sub1,w2_sub1,w3_sub1,subWord,w7_beforeSub,w7_beforeRot,w3_afterSub,w3_beforeSub;
 
RotWord r (w7_beforeRot,w7_beforeSub);
SubBytes s({w7_beforeSub,w_curr[63:32],w_curr[95:64],w_curr[127:96]},{subWord,w1_sub,w2_sub,w3_sub});
SubBytes s1({w3_beforeSub,w_curr[63:32],w_curr[95:64],w_curr[127:96]},{w3_afterSub,w1_sub1,w2_sub1,w3_sub1});

assign w7_beforeRot = w_curr[32*Nk -1 : 32*Nk -32];
assign w3_beforeSub = w_next[127 : 96];

integer i;

always @* begin 

for (i = 1;i <=Nk ; i = i+ 1) begin 
if(i == 1) begin
w_next[31:0] = w_curr[31:0] ^ subWord ^ rcon;
end 
else if (Nk == 8 && i == 5) begin 
w_next[32*i - 1 -: 32 ] = w_curr[32*i - 1 -: 32] ^ w3_afterSub;
end
else begin 
w_next[32*i - 1 -: 32] = w_next[32*(i-1) - 1 -: 32] ^ w_curr[32*i - 1 -: 32];
end 
end
end



endmodule