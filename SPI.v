module SPI(
    rst,
    clk,
    cs,
    serialkeyin,
    parallelkeyout,
    serialmessagein,
    parallelmessageout,
    parallelprocessedin,
    serialprocessedout,
);

input rst;
input clk;
input cs;
input serialkeyin;
input serialmessagein;
input [127:0] parallelprocessedin;
output reg [255:0] parallelkeyout;
output reg [127:0] parallelmessageout;
output reg serialprocessedout;

integer count = 0;

// 1 - Input
// 0 - Output
reg status = 1'b1;

always @ (posedge clk)
begin
	if (rst) 
			begin
					parallelkeyout[255:0] <= {(256){1'b0}};
					parallelmessageout[127:0] <= {(128){1'b0}};
			end
	else if ((cs == 1'b1) && (status == 1'b1)) 
			begin
					if(count <= 127)
					begin
							parallelkeyout[count-1] <= serialkeyin;
							parallelmessageout[count-1] <= serialmessagein;
					end else if (count <= 255)
					begin
							parallelkeyout[count-1] <= serialmessagein;
					end
			end
        
end

always @ (negedge cs)
begin
    status = ~status;
end

always @ (negedge clk)
    if ((cs == 1'b1) && (status == 1'b0)) 
    begin
        if(count <= 127)
        begin
            serialprocessedout <= parallelprocessedin[count-1];
        end
    end

always @ (clk)
	if(count <= 255 && cs && clk != status)
		count = count + 1;
  else if (!cs || rst)
		count = 0;

endmodule