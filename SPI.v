module SPI(
    rst,
    clk,
    cs,
    miso,
    parallelkeyout,
    parallelmessageout,
		mosi,
    parallelprocessedin,
		count
);

input rst;
input clk;
input cs;
input miso;
input [127:0] parallelprocessedin;
output reg [255:0] parallelkeyout;
output reg [127:0] parallelmessageout;
output reg mosi;
output reg [8:0] count;

integer counter = 0;

// 1 - Input
// 0 - Output
reg status;

always @ (posedge clk)
begin
	if (rst) 
			begin
					parallelkeyout[255:0] <= {(256){1'b0}};
					parallelmessageout[127:0] <= {(128){1'b0}};
			end
	else if ((cs == 1'b1) && (status == 1'b1)) 
			begin
					if(counter <= 128)
					begin
						parallelmessageout[counter-1] <= miso;
					end else if (counter <= 384)
					begin
						parallelkeyout[counter-129] <= miso;
					end
			end
        
end

always @ (negedge cs, posedge rst)
begin
	if(rst)
		status = 1'b1;
	else
		status = ~status;
end

always @ (negedge clk)
begin
	if ((cs == 1'b1) && (status == 1'b0)) 
	begin
			if(counter <= 128)
			begin
					mosi <= parallelprocessedin[counter-1];
			end
	end
end

always @ (clk)
begin
	if(counter <= 383 && cs && clk != status)
		counter = counter + 1;
  else if (!cs || rst)
	begin
	  if (counter == 384 && !rst)
			count <= 256;
		else if (counter > 320 && !rst)
			count <= 192;
		else if (counter > 256 && !rst)
			count <= 126;
		else
			count <= 0;
		counter = 0;
	end
	else
		counter = counter;
end

endmodule