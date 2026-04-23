`timescale 1ns/1ps
module wingen_test;
	reg clk;
	wire[7:0] new_pix, row, col;

	initial begin
		clk = 0;
	end

	always #5 clk = ~clk;
	
	top DUT (.clk_o(clk), .new_pix(new_pix), .row(row), .col(col));

	initial begin
		$stop;
		#5000000
		$finish;
	end
endmodule

