`timescale 1ns / 1ps

module Microprocessor(
		input origclk,
		input reset,
		input [7:0] instruction,
		output reg [7:0] pc,
		output reg [13:0] write_data_display
	);

	wire [1:0] op = instruction[7:6];
	wire [1:0] rs = instruction[5:4];
	wire [1:0] rt = instruction[3:2];
	wire [1:0] rd = instruction[1:0];
	wire [1:0] imm = instruction[1:0];

	wire clk;

	ClockDivider divider(
			.clkin(origclk),
			.clr(reset),
			.clkout(clk)
		);

	wire reg_dst;
	wire reg_write;
	wire alu_src;
	wire branch;
	wire mem_read;
	wire mem_write;
	wire mem_to_reg;
	wire alu_op;

	Control control(
			.op(op)
			.reg_dst(reg_dst),
			.reg_write(reg_write),
			.alu_src(alu_src),
			.branch(branch),
			.mem_read(mem_read),
			.mem_write(mem_write),
			.mem_to_reg(mem_to_reg),
			.alu_op(alu_op)
		);

	wire reg_data1;
	wire reg_data2;

	wire alu_result;

	Registers registers(
		.clk(clk),
		.reset(reset),
		.read_reg1(rs),
		.read_reg2(rt),
		.write(reg_write),
		.write_reg(reg_dst == 0 ? rt : rd),
		.write_data(alu_result),
		.read_data1(reg_data1),
		.read_data2(reg_data2)
		);


	ALU alu(
			.operand1(reg_data1),
			.operand2(alu_src == 0 ? reg_data2 : {7{imm[1]}, imm[0]}),
			.result(alu_result)
		);

endmodule
