`timescale 1ns / 1ps

module ClockDivider(
		input clkin,
		input clr,
		output reg clkout
    );
	
	reg [31:0] cnt;
	
	initial begin
		clkout <= 1'b0;
		cnt <= 0;
	end
	
	always @(posedge clr) begin
		clkout <= 1'b0;
		cnt <= 0;
	end
	
	always @(posedge clkin) begin
		if (clr) begin
			cnt <= 32'd0;
			clkout <= 1'b0;
		// end else if (cnt >= 32'd25000000) begin
		end else if (cnt >= 32'd10) begin
			cnt <= 32'b0;
			clkout <= ~clkout;
		end else begin
			cnt <= cnt + 1;
		end
	end
endmodule
