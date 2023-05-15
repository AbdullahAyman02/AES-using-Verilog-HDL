module TestWrapper(
	input clk, rst,
	output flagEncrypt, flagDecrypt
);

// Declare inputs as regs and outputs as wires
	reg		misoEncrypt;
	wire	mosiEncrypt;
	wire 	misoDecrypt;
	wire	mosiDecrypt;
	wire finishedEncrypt, finishedDecrypt;
	reg [127:0] ciphertext_reg;
	reg [127:0] originaltext_reg;
	reg	[127:0] key_reg = 128'h000102030405060708090a0b0c0d0e0f;
	reg [127:0] plaintext_reg = 128'h00112233445566778899aabbccddeeff;
	reg csEncrypt = 1'b1;
	reg csDecrypt = 1'b0;

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
			if(counterEncrypt < 127)
				misoEncrypt = plaintext_reg[counterEncrypt+1];
			else
				misoEncrypt = key_reg[counterEncrypt - 127];
		end
	end
 
	always @(posedge clk)
	begin
	if (!rst)
		begin
			if(!stateEncrypt && counterEncrypt <= 128)
				ciphertext_reg[counterEncrypt-1] = mosiEncrypt;
		end
  end

	always @(posedge clk)
	begin
	if (!rst)
		begin
			if(!stateDecrypt && counterDecrypt <= 127)
				originaltext_reg[counterDecrypt] = mosiDecrypt;
		end
  end

	always @ (clk)
	begin
	if(counterEncrypt <= 255 && csEncrypt && clk == stateEncrypt && !rst)
		counterEncrypt = counterEncrypt + 1;
  else if (!csEncrypt || rst)
	begin
		counterEncrypt = -1;
	end
	if(counterDecrypt <= 255 && csDecrypt && clk != stateDecrypt && !rst)
		counterDecrypt = counterDecrypt + 1;
  else if (!csDecrypt || rst)
	begin
		counterDecrypt = -1;
	end
	end

	always@(negedge clk, posedge rst)
	begin
		if(rst)
		begin
			csEncrypt = 1'b1;
			csDecrypt = 1'b0;
		end
		else 
		begin
			if(counterEncrypt == 256)
				csEncrypt = 1'b0;
			else if(finishedEncrypt)
			begin
				csDecrypt = 1'b1;
				csEncrypt = 1'b1;
			end
			else if(counterDecrypt == 256)
			begin
				csDecrypt = 1'b0;
				csEncrypt = 1'b0;
			end
			else if(finishedDecrypt)
				csDecrypt = 1'b1;
		end
	end

	assign flagEncrypt = (!rst) ? (ciphertext_reg == 128'h69c4e0d86a7b0430d8cdb78070b4c55a):0;
	assign flagDecrypt = (!rst) ? (originaltext_reg == 128'h00112233445566778899aabbccddeeff):0;
	assign misoDecrypt = (counterDecrypt <= 128) ? mosiEncrypt : key_reg[counterDecrypt - 129];
endmodule
