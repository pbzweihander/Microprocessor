`timescale 1ns / 1ps

module Microprocessor(
		input origclk,
		input reset,
		input [7:0] instruction,
		output reg [7:0] pc,
		output reg [13:0] write_data_display,
		output [7:0] debug_alu_result
	);

	wire [1:0] op = instruction[7:6];
	wire [1:0] rs = instruction[5:4];
	wire [1:0] rt = instruction[3:2];
	wire [1:0] rd = instruction[1:0];
	wire [7:0] imm = {
			instruction[1],
			instruction[1],
			instruction[1],
			instruction[1],
			instruction[1],
			instruction[1],
			instruction[1],
			instruction[0]
		};

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
			.op(op),
			.reg_dst(reg_dst),
			.reg_write(reg_write),
			.alu_src(alu_src),
			.branch(branch),
			.mem_read(mem_read),
			.mem_write(mem_write),
			.mem_to_reg(mem_to_reg),
			.alu_op(alu_op)
		);

	wire [7:0] reg_data1;
	wire [7:0] reg_data2;

	wire [7:0] alu_result;
	wire [7:0] memory_output;
	
	assign debug_alu_result = alu_result;
	
	wire [7:0] reg_write_data = mem_to_reg == 0 ? alu_result : memory_output;

	Registers registers(
			.clk(clk),
			.reset(reset),
			.read_reg1(rs),
			.read_reg2(rt),
			.write(reg_write),
			.write_reg(reg_dst == 0 ? rt : rd),
			.write_data(reg_write_data),
			.read_data1(reg_data1),
			.read_data2(reg_data2)
		);

	SevenSegmentDecoder ssdecoder1(
			.bcd(reg_write_data[7:4]),
			.seg(write_data_display[13:7])
		);
	SevenSegmentDecoder ssdecoder2(
			.bcd(reg_write_data[3:0]),
			.seg(write_data_display[6:0])
		);

	ALU alu(
			.operand1(reg_data1),
			.operand2(alu_src == 0 ? reg_data2 : imm),
			.result(alu_result)
		);

	DataMemory memory(
			.clk(clk),
			.reset(reset),
			.address(alu_result),
			.read(mem_read),
			.write(mem_write),
			.data_inputs(reg_data2),
			.data_outputs(memory_output)
		);
		
	initial begin
		pc <= 0;
	end
	
	always @(posedge reset) begin
		pc <= 0;
	end

	always @(posedge clk) begin
		pc <= branch == 0 ? pc + 1 : pc + 1 + imm;
	end
endmodule
