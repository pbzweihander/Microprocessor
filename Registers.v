`timescale 1ns / 1ps

module Registers(
		input clk,
		input reset,
		input [1:0] read_reg1,
		input [1:0] read_reg2,
		input write,
		input [1:0] write_reg,
		input [7:0] write_data,
		output reg [7:0] read_data1,
		output reg [7:0] read_data2
    );

	reg [7:0] reg0;
	reg [7:0] reg1;
	reg [7:0] reg2;
	reg [7:0] reg3;

	always @(posedge reset) begin
		reg0 <= 0;
		reg1 <= 0;
		reg2 <= 0;
		reg3 <= 0;
	end

	always @(posedge clk) begin
		 case (read_reg1)
			2'b00: read_data1 <= reg0;
			2'b01: read_data1 <= reg1;
			2'b10: read_data1 <= reg2;
			2'b11: read_data1 <= reg3;
		endcase
		 case (read_reg2)
			2'b00: read_data2 <= reg0;
			2'b01: read_data2 <= reg1;
			2'b10: read_data2 <= reg2;
			2'b11: read_data2 <= reg3;
		endcase
	end

	always@(negedge clk && write) begin
		 case (write_reg)
			2'b00: reg0 <= write_data;
			2'b01: reg1 <= write_data;
			2'b10: reg2 <= write_data;
			2'b11: reg3 <= write_data;
		endcase
	end
endmodule
