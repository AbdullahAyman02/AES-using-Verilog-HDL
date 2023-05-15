module generalKeyExpansion#(parameter Nk=4,parameter Nr=10)
(
    key,
    out,
     clk

);


localparam key_size = 4*(Nr+1)*32 - 1;
localparam round_size = Nk * 32;

input [Nk*48 - 1:0]key;
input clk;
output reg [key_size:0]out;

integer counter = 0;
integer firstEdge = 1;
reg [32*Nk - 1 :0] keyIn;
wire [ 32*Nk - 1 :0] keyOut;

generalExpandKey #(.Nk(Nk)) expandKey (r_con(counter-1),keyIn,keyOut);

always @(posedge clk) 
begin 

   if (counter == 1) 
    begin
        keyIn = key;
    end
    else if (counter > 1) 
    begin 
        keyIn = keyOut;
    end 
    counter = counter + 1;
end

always @(negedge clk) 
begin 
        if (counter == 0) 
        begin
            out[key_size -: round_size] = key;
        end
        else
        begin
            out[key_size - round_size*(counter-1) -: round_size] = keyOut;
        end
end

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