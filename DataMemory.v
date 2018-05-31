`timescale 1ns / 1ps

module DataMemory(
		input clk,
		input reset,
		input [7:0] address,
		input read,
		input write,
		input [7:0] data_inputs,
		output reg [7:0] data_outputs
    );

	reg [7:0] registers[31:0];
	integer i;

	initial begin
		for (i = 0; i < 16; i = i + 1) begin
			registers[i] <= i;
		end
		for (i = 0; i < 16; i = i + 1) begin
			registers[i + 16] <= -i;
		end
		data_outputs <= 0;
	end

	always @(posedge reset) begin
		for (i = 0; i < 16; i = i + 1) begin
			registers[i] <= i;
		end
		for (i = 0; i < 16; i = i + 1) begin
			registers[i + 16] <= -i;
		end
		data_outputs <= 0;
	end

	always @(posedge clk) begin
		if (read)
			data_outputs <= registers[address[4:0]];
		if (write)
			registers[address[4:0]] <= data_inputs;
	end
endmodule
