`timescale 1ns / 1ps

module IntegrationTest;
	reg origclk;
	reg reset;
	reg [7:0] instruction;
	wire [7:0] pc;
	wire [6:0] write_data_display_low;
	wire [6:0] write_data_display_high;

	wire [7:0] instruction_memory[2:0];

	assign instruction_memory[0] = { 2'd1, 2'd3, 2'd0, 2'b01 }; // lw s0, 1(s3)
	assign instruction_memory[1] = { 2'd0, 2'd0, 2'd1, 2'd1 }; // add s1, s0, s1
	assign instruction_memory[2] = { 2'd3, 2'd0, 2'd0, 2'b10 }; // j -2

	Microprocessor uut (
		.origclk(origclk),
		.reset(reset),
		.instruction(instruction),
		.pc(pc),
		.write_data_display_low(write_data_display_low),
		.write_data_display_high(write_data_display_high)
	);

	initial begin
		origclk = 0;
		reset = 0;
		instruction <= instruction_memory[0];
		#10;
		reset = 1;
		#10;
		reset = 0;
	end

	always begin
		origclk = 1;
		#1;
		origclk = 0;
		#1;
	end

	always @(pc) begin
		instruction <= instruction_memory[pc];
	end
endmodule
