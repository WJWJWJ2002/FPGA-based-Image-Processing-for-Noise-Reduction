`timescale 1ns/1ps
module wingen_test;
	reg clk, rst_sync, clk_100;
	reg[16:0] pix_count;
	wire done_filt, rst;
	wire[7:0] centre_pix;
	integer f;

	initial begin
		f = $fopen("new_pix.txt", "w");
		clk = 1'b0;
		clk_100 = 1'b0;
		pix_count = 1'b0;
		rst_sync = 1'b0;
		#1000
		rst_sync = 1'b1;
		#15_000_000
		f = $fopen("new_pix.txt", "w");
		rst_sync = 1'b0;
	end

	always #10 clk = ~clk;
	always #5 clk_100 = ~clk_100;
	top DUT (.clk(clk), .rst_sync(rst_sync), .new_pix_ff(centre_pix), .done_filt_ff(done_filt), .rst_valid(rst));
	
	always @(posedge clk_100) begin
		if (done_filt) begin
			$fwrite(f, "%h\n", centre_pix);
			pix_count <= pix_count + 1'b1;
		end
		if (rst) begin
			pix_count <= 17'd0;
		end
	end
	
	always @(*) begin
		if (pix_count > 17'd65535) begin
			$fclose(f);
			$finish;
		end
	end
endmodule

