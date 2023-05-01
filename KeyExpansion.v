module KeyExpansion(
    key,
    out,
    //Nk
);

localparam Nk = 4;
localparam Nb = 4;
localparam Nr = 10;
localparam key_size = 4*(Nr+1)*32 - 1;

input [Nk*4*8 - 1:0]key;
output [key_size:0]out;

wire [127:0]w[Nr:0];

genvar i;
generate

assign w[0][127:0] = key;
assign out[key_size:key_size-127] = key;

for(i = 1; i <= Nr; i = i + 1) 
begin : expand_key
    ExpandKey expandkey(r_con(i), w[i - 1][127:96], w[i - 1][95:64], w[i - 1][63:32], w[i - 1][31:0], w[i][127:96], w[i][95:64], w[i][63:32], w[i][31:0]);
	 assign out[key_size - 128*i:key_size - 128*i-127] = w[i][127:0];
end

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
    4'h9: r_con=32'h1b000000;
    4'ha: r_con=32'h36000000;
    default: r_con=32'h00000000;
  endcase
  end
endfunction

endmodule