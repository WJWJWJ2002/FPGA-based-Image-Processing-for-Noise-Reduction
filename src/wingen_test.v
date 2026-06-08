`timescale 1ns/1ps
module wingen_test;
	`include "parameters.vh"
	reg clk, rst;
	reg[1:0] img_sel;
	reg[16:0] pix_count;
	wire done_filt, VGA_HS, VGA_VS, VGA_SYNC, VGA_BLANK, VGA_CLK, outclk_150;
	wire[7:0] VGA_R, VGA_G, VGA_B;
	wire[7:0] centre_pix;
	integer f0, f1, f2;

	initial begin
		$stop;
		f0 = $fopen("new_pix.txt", "w");
		f1 = $fopen("new_pix2.txt", "w");
		f2 = $fopen("new_pix3.txt", "w");
		clk = 1'b0;
		pix_count = 1'b0;
		rst = 1'b0;
		img_sel = 2'd0;
		`ifdef MEDIAN_FILTER
			 #8_000_000
		`endif
		`ifdef MEAN_FILTER
			#6_000_000
		`endif
		`ifdef BILATERAL_FILTER
			#20_000_000
		`endif
		img_sel = 2'd1;
		rst = 1'b1;
		#1000
		rst = 1'b0;
		`ifdef MEDIAN_FILTER
			#8_000_000
		`endif
		`ifdef MEAN_FILTER
			#6_000_000
		`endif
		`ifdef BILATERAL_FILTER
			#20_000_000
		`endif
		img_sel = 2'd2;
		rst = 1'b1;
		#1000;
		rst = 1'b0;
		`ifdef MEDIAN_FILTER
			 #8_000_000
		`endif
		`ifdef MEAN_FILTER
			#6_000_000
		`endif
		`ifdef BILATERAL_FILTER
			#20_000_000
		`endif
		$fclose(f0);
		$fclose(f1);
		$fclose(f2);
		$finish;
	end

	always #10 clk = ~clk;
	top DUT_0 (.clk(clk), 
		.rst(rst), 
		.new_pix_ff(centre_pix), 
		.done_filt_ff(done_filt), 
		.img_sel(img_sel),
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B),
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.VGA_SYNC_N(VGA_SYNC),
		.VGA_BLANK_N(VGA_BLANK),
		.VGA_CLK(VGA_CLK),
		.outclk_150(outclk_150),
		.seg1(),
		.seg2(),
		.seg3(),
	);
	
	always @(posedge outclk_150) begin
		if (done_filt) begin
			if (img_sel == 2'd0)
				$fwrite(f0, "%h\n", centre_pix);
			else if (img_sel == 2'd1)
				$fwrite(f1, "%h\n", centre_pix);
			else if (img_sel == 2'd2)
				$fwrite(f2, "%h\n", centre_pix);
			pix_count <= pix_count + 1'b1;
		end
		if (rst) begin
			pix_count <= 17'd0;
		end
	end
	
endmodule

