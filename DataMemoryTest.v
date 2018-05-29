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
	end
	
	always begin
		if (address == 8'b00011111) begin
			address <= 0;
		end else begin
			address <= address + 1;
		end
		read <= 1;
		clk <= 1;
		#10;
		clk <= 0;
		#10;
	end
endmodule
