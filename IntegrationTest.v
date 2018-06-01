`timescale 1ns / 1ps

module IntegrationTest;
	reg origclk;
	reg reset;
	reg [7:0] instruction;
	wire [7:0] pc;
	wire [6:0] write_data_display_low;
	wire [6:0] write_data_display_high;

    wire [7:0] MemByte[20:0];

    assign MemByte[0] = 8'b01000100;
    assign MemByte[1] = 8'b01001001;
    assign MemByte[2] = 8'b00011001;
    assign MemByte[3] = 8'b10000100;

    assign MemByte[4] = 8'b01000100;
    assign MemByte[5] = 8'b01001001;
    assign MemByte[6] = 8'b00011001;
    assign MemByte[7] = 8'b10000100;

    assign MemByte[8] = 8'b01000100;
    assign MemByte[9] = 8'b01001001;
    assign MemByte[10] = 8'b00011001;
    assign MemByte[11] = 8'b10000100;

    assign MemByte[12] = 8'b01000100;
    assign MemByte[13] = 8'b01001001;
    assign MemByte[14] = 8'b00011001;
    assign MemByte[15] = 8'b10000100;

    assign MemByte[16] = 8'b01000100;
    assign MemByte[17] = 8'b01001001;
    assign MemByte[18] = 8'b00011001;
    assign MemByte[19] = 8'b10000100;

    assign MemByte[20] = 8'b11000011;

    assign instruction = MemByte[pc];

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
endmodule
