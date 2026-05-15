module top(clk, rst_sync, new_pix_ff, done_filt_ff, rst_valid);
	`include "parameters.vh"
	input clk, rst_sync;
	output done_filt_ff, rst_valid;
	reg done_filt_ff=0;
	output[DATA_WIDTH-1:0] new_pix_ff;
	reg[DATA_WIDTH-1:0] new_pix_ff=0;
	wire outclk_25, outclk_100, rst, gen_req, done_init_buf, data_valid, rden_rom, rden_fifo2, done_filt, done_gen;
	wire[DATA_WIDTH-1:0] rom_out_ff, fifo2_out_ff, fifo1_out_ff, new_pix, row, col,
	p1, p2, p3, p4, p5, p6, p7, p8, p9;
	reg init_buff=0;
	reg[2:0] initial_delay=0;
	
	PLL	PLL_inst (
	.inclk0 ( clk ),
	.c0 ( outclk_100 ),
	.c1 ( outclk_25 )
	);

	rst_debounce rst_gen (.clk(outclk_100), 
		.rst_sync(rst_sync),
		.rst(rst)
	);

	fifo_rom_v2 memory_buffer (.clk(outclk_100), .rst(rst),
		.init_buff(init_buff), .gen_req(gen_req),
		.rden_rom(rden_rom), .rden_fifo2(rden_fifo2), 
		.rom_out_ff(rom_out_ff), .fifo1_out_ff(fifo1_out_ff), .fifo2_out_ff(fifo2_out_ff),
		.data_valid(data_valid), .done_init_buf(done_init_buf)
	);

	win_gen window_generation (.gen_ready(done_init_buf), 
		.gen_req(gen_req), 
		.clk(outclk_100), 
		.rst(rst),
		.rden_rom(rden_rom), 
		.rden_fifo2(rden_fifo2), 
		.done_gen(done_gen), 
		.done_filt(done_filt), 
		.data_valid(data_valid),
		.row1_out_ff(fifo2_out_ff), .row2_out_ff(fifo1_out_ff), .rom_out_ff(rom_out_ff), .row(row), .col(col),
		.p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7), .p8(p8), .p9(p9)
	);

	`ifdef DUMMY_FILTER
		dummy_filter filter_module (.clk(outclk_100), .rst(rst), .done_gen(done_gen), 
		.p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7), .p8(p8), .p9(p9),
		.done_filt(done_filt), .new_pix(new_pix)
		);
	`endif
	
	`ifdef MEDIAN_FILTER
		median_filter filter_module (.clk(outclk_100), .rst(rst), .done_gen(done_gen), 
		.p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7), .p8(p8), .p9(p9),
		.done_filt(done_filt), .new_pix(new_pix)
		);
	`endif

	`ifdef MEAN_FILTER
		mean_filter filter_module (.clk(outclk_100), .rst(rst), .done_gen(done_gen), 
		.p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7), .p8(p8), .p9(p9),
		.done_filt(done_filt), .new_pix(new_pix)
		);
	`endif

	always @(posedge outclk_100) begin
		done_filt_ff <= done_filt;
		new_pix_ff <= new_pix;
		if (rst) begin
			init_buff <= 1'b0;
			initial_delay <= 3'd0;
		end
		else if (initial_delay < 3'd7) begin
			init_buff <= 1'b0;
			initial_delay <= initial_delay + 1'b1;
		end
		else begin
			init_buff <= 1'b1;
			initial_delay <= initial_delay;
		end
	end
	
	assign rst_valid = rst;
endmodule

