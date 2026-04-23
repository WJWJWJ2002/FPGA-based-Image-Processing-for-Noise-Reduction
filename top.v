module top(clk, new_pix);
	`include "parameters.vh"
	input clk;
	output[DATA_WIDTH-1:0] new_pix;
	wire clk, gen_req, done_init_buf, data_valid, rden_rom, rden_fifo2, done_filt, done_gen;
	wire[DATA_WIDTH-1:0] rom_out_ff, fifo2_out_ff, fifo1_out_ff, row, col;
	reg init_buff;

	fifo_rom memory_buffer (.clk(clk), ,init_buff(init_buff), .gen_req(gen_req), .rden_rom(rden_rom), .rden_fifo2(rden_fifo2),        .rom_out_ff(rom_out_ff), .fifo1_out_ff(fifo1_out_ff), .fifo2_out_ff(fifo2_out_ff), 
	.data_valid(data_valid), .done_init_buf(done_init_buf)
	);

	win_gen window_generation (.gen_ready(done_init_buf), .gen_req(gen_req), .clk(clk), .rden_rom(rden_rom), 
	.rden_fifo2(rden_fifo2), .done_gen(done_gen), .done_filt(done_filt), .data_valid(data_valid),
	.row1_out_ff(fifo2_out_ff), .row2_out_ff(fifo1_out_ff), .rom_out_ff(rom_out_ff), .row(row), .col(col)
	.p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7), .p8(p8), .p9(p9)
	);

//	filter filter_module (.clk(clk), .done_gen(done_gen), 
//	.p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7), .p8(p8), .p9(p9),
//	.done_filt(done_filt), .new_pix(new_pix)
//	);

	initial begin
		init_buff = 1'b0;
		row = 8'd0;
		col = 8'd0;
	end

	always @(posedge clk) begin
		if (initial_delay < 3'd7) begin
			init_buff <= 1'b0;
			initial_delay <= initial_delay + 1'b1;
		end
		else begin
			init_buff <= 1'b1;
			initial_delay <= initial_delay;
			if (done_filt) begin
				row <= row + 1'b1;
				col <= col + 1'b1;
			end
		end
	end
endmodule

