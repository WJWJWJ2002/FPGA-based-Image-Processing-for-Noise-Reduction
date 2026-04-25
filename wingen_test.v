`timescale 1ns/1ps
module wingen_test;
	reg clk;
	reg[16:0] pix_count;
	wire done_gen;
	wire[7:0] centre_pix, row, col;

	initial begin
		clk = 0;
		pix_count = 0;
	end

	always #5 clk = ~clk;
	
	top DUT (.clk_o(clk), .new_pix(centre_pix), .done_gen(done_gen), .row(row), .col(col));

	always @(posedge clk) begin
		if (done_gen) begin
			$display("%d: %h", pix_count, centre_pix);
			pix_count <= pix_count + 1'b1;
		end
	end
	
	always @(*) begin
		if (pix_count > 17'd65535)
			$finish;
	end

	initial begin
		$stop;
	end
endmodule

