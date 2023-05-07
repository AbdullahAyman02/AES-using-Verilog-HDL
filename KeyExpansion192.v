module KeyExpansion192(
    key,
    out,
    //Nk
);

localparam Nk = 6;
localparam Nb = 4;
localparam Nr = 12;
localparam key_size = 4*(Nr+1)*32 - 1;

input [Nk*4*8 - 1:0]key;
output [key_size:0]out;

wire [191:0]w[8:0];

genvar i;
generate

assign w[0][191:0] = key;
assign out[key_size:key_size-191] = key;

for(i = 1; i <= 7; i = i + 1) 
begin : expand_key
    ExpandKey192 expandkey192(r_con(i), w[i - 1][191:160], w[i - 1][159:128], w[i - 1][127:96], w[i - 1][95:64], w[i - 1][63:32], w[i - 1][31:0], w[i][191:160], w[i][159:128], w[i][127:96], w[i][95:64], w[i][63:32], w[i][31:0]);
	 assign out[key_size - 192*i:key_size - 192*i-191] = w[i][191:0];
end

ExpandKey192 expandkey192_2(r_con(8), w[7][191:160], w[7][159:128], w[7][127:96], w[7][95:64], w[7][63:32], w[7][31:0], w[8][191:160], w[8][159:128], w[8][127:96], w[8][95:64], w[8][63:32], w[8][31:0]);
assign out[key_size - 192*8:key_size - 192*8-127] = w[8][191:64];

endgenerate

function[0:31] r_con;
input [0:4] r; 
begin
 case(r)
    4'h1: r_con=32'h01000000;
    4'h2: r_con=32'h02000000;
    4'h3: r_con=32'h04000000;
    4'h4: r_con=32'h08000000;
    4'h5: r_con=32'h10000000;
    4'h6: r_con=32'h20000000;
    4'h7: r_con=32'h40000000;
    4'h8: r_con=32'h80000000;
    default: r_con=32'h00000000;
  endcase
  end
endfunction

endmodule