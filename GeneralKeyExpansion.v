module GeneralKeyExpansion#(parameter Nk=6,parameter Nr=12)
(
    key,
    out,
	 clk
    
);


localparam key_size = 4*(Nr+1)*32 - 1;

input [Nk*4*8 - 1:0]key;
input clk;
integer temp = 0;
output reg [key_size:0]out;

wire [127:0]w ;
integer counter = 0;
integer firstEdgeCheck = 1;
reg [32*Nk - 1 :0] keyIn;
wire [ 32*Nk - 1 :0] keyOut;





generalExpandKey #(.Nk(Nk)) expandKey (r_con(counter),keyIn,keyOut);

always @(posedge clk) 
begin 

   if (counter == 0) begin
	firstEdgeCheck = 0;
	counter = counter + 1;
	temp = 1;
	end
	else if (counter == 1 && temp == 2) begin 
	keyIn = keyOut;
	counter = counter + 1;
	end
	else if(counter == 1 && temp == 1) begin 
	keyIn = key;
	temp = 2;
	end
	else begin
	keyIn = keyOut;
	counter = counter + 1;
	end
	
	 
end

always @(negedge clk) 
begin 
	if(firstEdgeCheck == 0) begin
	if (counter == 1 && temp == 1) begin
	out[key_size -: Nk*4*8] = key;
	end 
	else if(counter == 7 && Nk == 8) begin
	out[key_size - Nk*4*8*counter -: 128] = keyOut[127 : 0];
	end
	else if (Nk == 6 && counter == 8) begin 
	out[key_size - Nk*4*8*counter -: 128] = keyOut[127 : 0];
	end
	else begin 
	out[key_size - Nk*4*8*counter -: Nk*4*8] = keyOut;
	end
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