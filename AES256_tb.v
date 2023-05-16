module AES256_tb();

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
reg [255:0] key;
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
	key = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
	out = 128'h8ea2b7ca516745bfeafc49904b496089;
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

	for (i = 0;i < 256;i = i + 1)
	begin
		misoEncrypt = key[i];
		# (1*period); 
	end

	# (1/2* period)
	csEncrypt = 1'b0;
	# (1/2 * period)
	# (30 * period)
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
	
	for (i = 128;i < 256;i = i + 1)
	begin
		misoDecrypt = key[i];
		# (1*period); 
	end
		
	# (period / 4)
	csDecrypt = 1'b0;
	csEncrypt = 1'b0;
	# (period * 3 / 4)
	# (30 * period)
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

	
	dataIn_reg = 128'hffeeddccbbaa99887766554433221100;
	key = 256'h1234567898765432123456789876543223456789876543212345678987654321;
	out = 128'h47873078fce1892d61952dfdfbef037f;
	# period;

	csEncrypt = 1'b1;
	csDecrypt = 1'b0;

	encryptOut_reg = 128'h000000000000000000000000;
	decryptOut_reg = 128'h000000000000000000000000;

	# period;

	for (i = 0;i < 128;i = i + 1)
	begin
		misoEncrypt = dataIn_reg[i];
		# (1*period);
	end

	for (i = 0;i < 256;i = i + 1)
	begin
		misoEncrypt = key[i];
		# (1*period); 
	end

	# (1/2* period)
	csEncrypt = 1'b0;
	# (1/2 * period)
	# (30 * period)
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
	
	for (i = 128;i < 256;i = i + 1)
	begin
		misoDecrypt = key[i];
		# (1*period); 
	end
		
	# (period / 4)
	csDecrypt = 1'b0;
	csEncrypt = 1'b0;
	# (period * 3 / 4)
	# (30 * period)
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
  
Encrypt #(.Nk(8), .Nr(14), .Nb(4)) enc256(
    .rst(rst),
    .clk(clk),
    .cs(csEncrypt),
    .miso(misoEncrypt),
    .mosi(mosiEncrypt),
	.finished(finishedEncrypt)
);  

Decrypt #(.Nk(8), .Nr(14), .Nb(4)) dec256(
	.rst(rst),
    .clk(clk),
    .cs(csDecrypt),
    .miso(misoDecrypt),
    .mosi(mosiDecrypt), 
	.finished(finishedDecrypt)
);
endmodule
