module top(clk_o, new_pix, done_gen, row, col);
	`include "parameters.vh"
	input clk_o;
	output done_gen;
	output[DATA_WIDTH-1:0] new_pix, row, col;
	wire clk, gen_req, done_init_buf, data_valid, rden_rom, rden_fifo2, done_filt, done_gen;
	wire[DATA_WIDTH-1:0] rom_out_ff, fifo2_out_ff, fifo1_out_ff, new_pix, row, col,
	p1, p2, p3, p4, p5, p6, p7, p8, p9;
	reg init_buff;
	reg[2:0] initial_delay;

	initial begin
		initial_delay = 3'd0;
	end
	
	CLK_CTRL clk_pin (.inclk(clk_o), .outclk(clk));

	fifo_rom_v2 memory_buffer (.clk(clk), .init_buff(init_buff), .gen_req(gen_req),
		.rden_rom(rden_rom), .rden_fifo2(rden_fifo2), 
		.rom_out_ff(rom_out_ff), .fifo1_out_ff(fifo1_out_ff), .fifo2_out_ff(fifo2_out_ff),
		.data_valid(data_valid), .done_init_buf(done_init_buf)
	);

	win_gen window_generation (.gen_ready(done_init_buf), .gen_req(gen_req), .clk(clk), .rden_rom(rden_rom), 
	.rden_fifo2(rden_fifo2), .done_gen(done_gen), .done_filt(done_filt), .data_valid(data_valid),
	.row1_out_ff(fifo2_out_ff), .row2_out_ff(fifo1_out_ff), .rom_out_ff(rom_out_ff), .row(row), .col(col),
	.p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7), .p8(p8), .p9(p9)
	);

	dummy_filter filter_module (.clk(clk), .done_gen(done_gen), 
	.p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7), .p8(p8), .p9(p9),
	.done_filt(done_filt), .new_pix(new_pix)
	);

	always @(posedge clk) begin
		if (initial_delay < 3'd7) begin
			init_buff <= 1'b0;
			initial_delay <= initial_delay + 1'b1;
		end
		else begin
			init_buff <= 1'b1;
			initial_delay <= initial_delay;
		end
	end
endmodule

