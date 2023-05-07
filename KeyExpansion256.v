module KeyExpansion256(
    key,
    out,
    //Nk
);

localparam Nk = 8;
localparam Nb = 4;
localparam Nr = 14;
localparam key_size = 4*(Nr+1)*32 - 1;

input [Nk*4*8 - 1:0]key;
output [key_size:0]out;

wire [255:0]w[7:0];

genvar i;
generate

assign w[0][255:0] = key;
assign out[key_size:key_size-255] = key;

for(i = 1; i <= 6; i = i + 1) 
begin : expand_key
    ExpandKey256 expandkey256(r_con(i), w[i - 1][255:224], w[i - 1][223:192], w[i - 1][191:160], w[i - 1][159:128], w[i - 1][127:96], w[i - 1][95:64], w[i - 1][63:32], w[i - 1][31:0], w[i][255:224], w[i][223:192], w[i][191:160], w[i][159:128], w[i][127:96], w[i][95:64], w[i][63:32], w[i][31:0]);
	 assign out[key_size - 256*i:key_size - 256*i-255] = w[i][255:0];
end

ExpandKey256 expandkey256_2(r_con(7), w[6][255:224] , w[6][223:192], w[6][191:160], w[6][159:128], w[6][127:96], w[6][95:64], w[6][63:32], w[6][31:0], w[7][255:224] , w[7][223:192] , w[7][191:160], w[7][159:128], w[7][127:96], w[7][95:64], w[7][63:32], w[7][31:0]);
assign out[key_size - 256*7:key_size - 256*7-127] = w[7][255:128];

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
    default: r_con=32'h00000000;
  endcase
  end
endfunction

endmodule