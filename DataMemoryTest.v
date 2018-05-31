`timescale 1ns / 1ps

module DataMemoryTest;
	reg clk;
	reg reset;
	reg [7:0] address;
	reg read;
	reg write;
	reg [7:0] data_inputs;
	wire [7:0] data_outputs;
	
	DataMemory uut (
		.clk(clk), 
		.reset(reset), 
		.address(address), 
		.read(read), 
		.write(write), 
		.data_inputs(data_inputs), 
		.data_outputs(data_outputs)
	);

	initial begin
		clk = 0;
		reset = 0;
		address = 0;
		read = 0;
		write = 0;
		data_inputs = 0;
		
		#100;
		
		address = 8'b00000010;
		data_inputs = 8'b01010101;
		read = 0;
		write = 1;
		clk = 1;
		#50;
		clk = 0;
		#50;
		
		address = 8'b00001010;
		data_inputs = 8'b11001100;
		read = 0;
		write = 1;
		clk = 1;
		#50;
		clk = 0;
		#50;
		
		address = 8'b00000010;
		read = 1;
		write = 0;
		clk = 1;
		#50;
		clk = 0;
		#50;
		
		address = 8'b00001010;
		read = 1;
		write = 0;
		clk = 1;
		#50;
		clk = 0;
		#50;
	end
endmodule
