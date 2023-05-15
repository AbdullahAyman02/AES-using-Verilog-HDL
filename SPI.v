module SPI#(parameter Nk=4)(
    rst,
    clk,
    cs,
    miso,
    parallelkeyout,
    parallelmessageout,
		mosi,
    parallelprocessedin,
	 ready
);

input rst;
input clk;
input cs;
input miso;
input [127:0] parallelprocessedin;
output reg [Nk*32-1:0] parallelkeyout;
output reg [127:0] parallelmessageout;
output reg mosi;
output reg ready;

integer counter = 0;

// 1 - Input
// 0 - Output
reg state;

always @ (posedge clk)
begin
	if (rst) 
			begin
					parallelkeyout[Nk*32-1:0] = {(Nk*32){1'b0}};
					parallelmessageout[127:0] = {(128){1'b0}};
			end
	else if ((cs == 1'b1) && (state == 1'b1)) 
			begin
					if(counter < 128)
					begin
						parallelmessageout[counter] = miso;
					end else if (counter <= (Nk*32+128))
					begin
						parallelkeyout[counter-128] = miso;
					end
			end      
end

always @ (negedge cs, posedge rst)
begin
	if(rst)
		state = 1'b1;
	else if(!cs)
	begin
		state = ~state;
		if(!state && (counter == (Nk*32-1+128)+1))
			ready = 1'b1;
		else
			ready = 1'b0;
	end
end


always @ (negedge clk)
begin
	if ((cs == 1'b1) && (state == 1'b0)) 
	begin
			if(counter < 128)
			begin
					mosi = parallelprocessedin[counter];
			end
	end
end

always @ (clk)
begin
	if(counter <= (Nk*32-1+128) && cs && clk != state && !rst)
		counter = counter + 1;
  else if (!cs || rst)
	begin
		counter = -1;
	end
end

endmodule