module Encrypt128_tb();

reg clk;
reg rst;
reg csEncrypt;
reg csDecrypt;
reg misoEncrypt;
reg misoDecrypt;
wire mosiEncrypt;
wire mosiDecrypt;
reg [127:0] dataIn_reg;
reg [127:0] key;
reg [127:0] encryptOut_reg;
reg [127:0] decryptOut_reg;
reg [127:0] out;
reg flagEncrypt;
reg flagDecrypt;
   
localparam period = 10;
integer i;
	
initial begin   	
	flagEncrypt = 0;
	flagDecrypt = 0;
	clk = 1;
	rst = 1'b1;
	csEncrypt = 1'b0;
	csDecrypt = 1'b0;
	dataIn_reg = 128'h00112233445566778899aabbccddeeff;
	key = 128'h000102030405060708090a0b0c0d0e0f;
	out = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
	# period;
	encryptOut_reg = 128'h000000000000000000000000;
	decryptOut_reg = 128'h000000000000000000000000;
	rst = 1'b0;
	csEncrypt = 1'b1;
	# period;

	for (i = 0;i < 128;i = i + 1)
	begin
		misoEncrypt = dataIn_reg[i];
		# (1*period);
	end

	for (i = 0;i < 128;i = i + 1)
	begin
		misoEncrypt = key[i];
		# (1*period); 
	end

	csEncrypt = 1'b0;
	# (1*period);
	csEncrypt = 1'b1;
	csDecrypt = 1'b1;
	# (1*period);


	for (i = 0;i < 128;i = i + 1)
	begin
		encryptOut_reg[i] = mosiEncrypt;
		misoDecrypt = mosiEncrypt;
		# (1*period);
	end

	for (i = 0;i < 128;i = i + 1)
	begin
		misoDecrypt = key[i];
		if (encryptOut_reg[i] == out[i])
		begin
			flagEncrypt = 1;
			$display("Testcase Encrypt %d Passed", i);
		end
		else
		begin
			flagEncrypt = 0;
			$display("Testcase Encrypt %d failed", i);
		end
		# (1*period);
	end

	csDecrypt = 1'b0;
	# (1*period);
	csDecrypt = 1'b1;
	# (1*period);

	for (i = 0;i < 128;i = i + 1)
	begin
		decryptOut_reg[i] = mosiDecrypt;
		# (1*period);
	end

	for (i = 0;i < 128;i = i + 1)
	begin
		if (decryptOut_reg[i] == dataIn_reg[i])
		begin
			flagDecrypt = 1;
			$display("Testcase Decrypt %d Passed", i);
		end
		else
		begin
			flagDecrypt = 0;
			$display("Testcase Decrypt %d failed", i);
		end
		# (1*period);
	end
end
  
always begin
	# (period/2) clk = ~clk;
end
  
Encrypt #(.Nk(4), .Nr(10), .Nb(4)) enc128(
    .rst(rst),
    .clk(clk),
    .cs(csEncrypt),
    .miso(misoEncrypt),
    .mosi(mosiEncrypt)
);  

Decrypt #(.Nk(4), .Nr(10), .Nb(4)) dec128(
	.rst(rst),
    .clk(clk),
    .cs(csDecrypt),
    .miso(misoDecrypt),
    .mosi(mosiDecrypt)
);
endmodule
