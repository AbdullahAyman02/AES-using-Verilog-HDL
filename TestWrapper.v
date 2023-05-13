module TestWrapper(
	input clk, rst, csEncrypt, csDecrypt,
	output flagEncrypt, flagDecrypt
);

// Declare inputs as regs and outputs as wires
	reg		misoEncrypt;
	wire	mosiEncrypt;
	wire 	misoDecrypt;
	wire	mosiDecrypt;
	reg [127:0] ciphertext_reg;
	reg [127:0] originaltext_reg;
	reg	[127:0] key_reg = 128'h000102030405060708090a0b0c0d0e0f;
	reg [127:0] plaintext_reg = 128'h00112233445566778899aabbccddeeff;

	// 1->128 2->192 3->256
	// reg [0:3] keysize_reg = 4'h1
	reg stateEncrypt;
	reg stateDecrypt;
   
	integer counterEncrypt;
	integer counterDecrypt;
 
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

	// Encrypt enc192 (parameter Nk=6,parameter Nr=12,parameter Nb = 4)(
	// 	rst,
	// 	clk,
	// 	cs,
	// 	miso,
	// 	mosi
	// );
	// Encrypt enc256 (parameter Nk=8,parameter Nr=14,parameter Nb = 4)(
	// 	rst,
	// 	clk,
	// 	cs,
	// 	miso,
	// 	mosi
	// );
	
	always @ (negedge csEncrypt, posedge rst)
	begin
		if(rst)
			stateEncrypt = 1'b1;
		else
			stateEncrypt = ~stateEncrypt;
	end
  
	always @ (negedge csDecrypt, posedge rst)
	begin
		if(rst)
			stateDecrypt = 1'b1;
		else
			stateDecrypt = ~stateDecrypt;
	end

	always @(negedge clk) 
	begin
		if (stateEncrypt)
		begin
			if(counterEncrypt < 128)
				misoEncrypt = plaintext_reg[counterEncrypt];
			else
				misoEncrypt = key_reg[counterEncrypt - 128];
		end
	end

	// always @(negedge clk) 
	// begin
	// 	if (stateDecrypt)
	// 	begin
	// 		if(counterDecrypt < 128)
	// 			misoDecrypt = mosiEncrypt;
	// 		else
	// 			misoDecrypt = key_reg[counterDecrypt - 128];
	// 	end
	// end
 
	always @(posedge clk, posedge rst, negedge csEncrypt)
	begin
	if (rst || !csEncrypt) 
		begin
			counterEncrypt = -1;
		end
	else if (!rst)
		begin
			if(!stateEncrypt && counterEncrypt <= 127)
				ciphertext_reg[counterEncrypt] = mosiEncrypt;
			if (counterEncrypt <= 255)
				counterEncrypt = counterEncrypt + 1;
		end
  end

	always @(posedge clk, posedge rst, negedge csDecrypt)
	begin
	if (rst || !csDecrypt) 
		begin
			counterDecrypt = -1;
		end
	else if (!rst)
		begin
			if(!stateDecrypt && counterDecrypt <= 127)
				originaltext_reg[counterDecrypt] = mosiDecrypt;
			if (counterDecrypt <= 255)
				counterDecrypt = counterDecrypt + 1;
		end
  end

	assign flagEncrypt = (ciphertext_reg == 128'h69c4e0d86a7b0430d8cdb78070b4c55a);
	assign flagDecrypt = (originaltext_reg == 128'h00112233445566778899aabbccddeeff);
	assign misoDecrypt = (counterDecrypt < 128) ? mosiEncrypt : key_reg[counterDecrypt - 128];
endmodule
