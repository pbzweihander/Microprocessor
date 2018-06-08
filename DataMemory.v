`timescale 1ns / 1ps

module DataMemory(
		input clk,
		input reset,
		input [7:0] address,
		input write,
		input [7:0] data_inputs,
		output [7:0] data_outputs
	);

	reg [7:0] registers[31:0];
	integer i;

	assign data_outputs = registers[address[4:0]];

	initial begin
		for (i = 0; i < 16; i = i + 1) begin
			registers[i] <= i;
		end
		for (i = 0; i < 16; i = i + 1) begin
			registers[i + 16] <= -i;
		end
		data_outputs <= 0;
	end

	always @(posedge reset or clk) begin
		if (reset) begin
			for (i = 0; i < 16; i = i + 1) begin
				registers[i] <= i;
			end
			for (i = 0; i < 16; i = i + 1) begin
				registers[i + 16] <= -i;
			end
			data_outputs <= 0;
		end else if (write && !clk)
			registers[address[4:0]] <= data_inputs;
	end
endmodule
