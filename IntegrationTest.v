`timescale 1ns / 1ps

module IntegrationTest;
	reg origclk;
	reg reset;
	reg [7:0] instruction;
	wire [7:0] pc;
	wire [13:0] write_data_display;
	wire [7:0] debug_alu_result;

	wire [7:0] instruction_memory[5:0];

	assign instruction_memory[0] = { 2'd1, 2'd0, 2'd1, 2'd0 };
	assign instruction_memory[1] = { 2'd1, 2'd0, 2'd2, 2'd1 };
	assign instruction_memory[2] = { 2'd0, 2'd1, 2'd2, 2'd0 };
	assign instruction_memory[3] = { 2'd2, 2'd0, 2'd2, 2'd1 };
	assign instruction_memory[4] = { 2'd3, 2'd0, 2'd0, 2'd3 };

	Microprocessor uut (
		.origclk(origclk),
		.reset(reset),
		.instruction(instruction),
		.pc(pc),
		.write_data_display(write_data_display),
		.debug_alu_result(debug_alu_result)
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

