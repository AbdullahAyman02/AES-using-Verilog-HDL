module TestWrapper(
	input clk, rst,
	output reg flag
);

// Declare inputs as regs and outputs as wires
	reg		miso;
	wire	mosi;
	reg [127:0] ciphertext_reg;
	reg	[127:0] key_reg = 128'h000102030405060708090a0b0c0d0e0f;
	reg [127:0] plaintext_reg = 128'h00112233445566778899aabbccddeeff;

	// 1->128 2->192 3->256
	// reg [0:3] keysize_reg = 4'h1
	reg state;
	reg cs;
   
	integer counter;
 
	Encrypt enc(
		rst,
		clk,
		cs,
		miso,
		mosi
	);
	
	always @ (negedge cs, posedge rst)
	begin
		if(rst)
			state = 1'b1;
		else
			state = ~state;
	end
  
	always @(negedge clk) 
	begin
		if (state)
		begin
			if(counter < 128)
				miso = plaintext_reg[counter];
			else
				miso = key_reg[counter - 128];
		end
	end
 
	always @(posedge clk, posedge(rst)) 
	begin
	if (rst) 
		begin
			cs = 1'b1;
			counter = 0;
			flag = 1'b0;
		end
	else 
		begin
			if(!state)
				ciphertext_reg[counter] = mosi;
			if (counter <= 383)
				counter = counter + 1;
			else
				flag = (ciphertext_reg == 128'h69c4e0d86a7b0430d8cdb78070b4c55a);
		end
  end
 endmodule
