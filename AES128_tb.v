module AES128_tb();

reg clk;
reg rst;
reg csEncrypt;
reg csDecrypt;
reg misoEncrypt;
reg misoDecrypt;
wire mosiEncrypt;
wire mosiDecrypt;
wire finishedEncrypt;
wire finishedDecrypt;
reg [127:0] dataIn_reg;
reg [127:0] key;
reg [127:0] encryptOut_reg;
reg [127:0] decryptOut_reg;
reg [127:0] out;
reg flagEncrypt;
reg flagDecrypt;
reg	[0:8]count;				//maximum is 256 therefore 8 bits
   
localparam period = 10;
integer i;
	
initial begin   	
	flagEncrypt = 0;
	flagDecrypt = 0;
	count = 0;
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

	# (1/2* period)
	csEncrypt = 1'b0;
	# (1/2 * period)
	# (26 * period)
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
		if (encryptOut_reg[i] != out[i])
		begin
			count = count + 1;
			$display("Testcase 1 Encryption %d failed", i);
		end
		else
			$display("Testcase 1 Encryption %d Passed", i);
		# (1*period);
	end
	if(count == 0)
		flagEncrypt = 1'b1;
		
	# (period / 4)
	csDecrypt = 1'b0;
	csEncrypt = 1'b0;
	# (period * 3 / 4)
	# (26 * period)
	csDecrypt = 1'b1;
	# (1*period);

	for (i = 0;i < 128;i = i + 1)
	begin
		decryptOut_reg[i] = mosiDecrypt;
		# (1*period);
	end

	count = 0;
	for (i = 0;i < 128;i = i + 1)
	begin
		if (decryptOut_reg[i] != dataIn_reg[i])
		begin
			count = count + 1;
			$display("Testcase 1 Decryption %d failed", i);
		end
		else
			$display("Testcase 1 Decryption %d Passed", i);
		# (1*period);
	end

	if(count == 0)
		flagDecrypt = 1'b1;

	# (1*period)

	flagDecrypt = 0;
	flagEncrypt = 0;
	count = 0;

	dataIn_reg = 128'h3243f6a8885a308d313198a2e0370734;
	key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
	out = 128'h3925841d02dc09fbdc118597196a0b32;

	csEncrypt = 1'b1;
	csDecrypt = 1'b0;
	# (1*period)

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

	# (1/2* period)
	csEncrypt = 1'b0;
	# (1/2 * period)
	# (26 * period)
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
		if (encryptOut_reg[i] != out[i])
		begin
			count = count + 1;
			$display("Testcase 2 Encryption %d failed", i);
		end
		else
			$display("Testcase 2 Encryption %d Passed", i);
		# (1*period);
	end
	if(count == 0)
		flagEncrypt = 1'b1;

	# (period / 4)
	csDecrypt = 1'b0;
	# (period * 3 / 4)
	# (26 * period)
	csDecrypt = 1'b1;
	# (1*period);

	for (i = 0;i < 128;i = i + 1)
	begin
		decryptOut_reg[i] = mosiDecrypt;
		# (1*period);
	end

	count = 0;
	for (i = 0;i < 128;i = i + 1)
	begin
		if (decryptOut_reg[i] != dataIn_reg[i])
		begin
			count = count + 1;
			$display("Testcase 2 Decryption %d failed", i);
		end
		else
			$display("Testcase 2 Decryption %d Passed", i);
		# (1*period);
	end

	if(count == 0)
		flagDecrypt = 1'b1;

	# (1*period);
end
  
always begin
	# (period/2) clk = ~clk;
end
  
Encrypt #(.Nk(4), .Nr(10), .Nb(4)) enc128(
    .rst(rst),
    .clk(clk),
    .cs(csEncrypt),
    .miso(misoEncrypt),
    .mosi(mosiEncrypt),
	.finished(finishedEncrypt)
);  

Decrypt #(.Nk(4), .Nr(10), .Nb(4)) dec128(
	.rst(rst),
    .clk(clk),
    .cs(csDecrypt),
    .miso(misoDecrypt),
    .mosi(mosiDecrypt), 
	.finished(finishedDecrypt)
);
endmodule
