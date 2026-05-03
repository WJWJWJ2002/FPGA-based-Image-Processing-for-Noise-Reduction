`timescale 1ns/1ps
module wingen_test;
	reg clk;
	reg[16:0] pix_count;
	wire done_filt;
	wire[7:0] centre_pix;
	integer f;

	initial begin
		clk = 0;
		pix_count = 0;
		$stop;
		f = $fopen("new_pix.txt", "w");
		$display("start");
	end

	always #1 clk = ~clk;
	
	top DUT (.clk(clk), .new_pix_ff(centre_pix), .done_filt_ff(done_filt));

	always @(posedge clk) begin
		if (done_filt) begin
			$fwrite(f, "%h\n", centre_pix);
			$display("%h", centre_pix);
			pix_count <= pix_count + 1'b1;
		end
	end
	
	always @(*) begin
		if (pix_count > 17'd65535) begin
			$fclose(f);
			$display("end");
			$finish;
		end
	end
endmodule

