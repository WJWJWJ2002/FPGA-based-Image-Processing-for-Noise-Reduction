module top(clk, rst_sync, VGA_R, VGA_G, VGA_B, VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, new_pix_ff, done_filt_ff, rst_valid, seg1, seg2, seg3, seg4, seg5, seg6);
	`include "parameters.vh"
	input clk, rst_sync;
	output done_filt_ff, rst_valid, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_CLK;
	reg done_filt_ff=0;
	output[7:0] VGA_R, VGA_G, VGA_B;
	output[DATA_WIDTH-1:0] new_pix_ff, seg1, seg2, seg3, seg4, seg5, seg6;
	reg[DATA_WIDTH-1:0] new_pix_ff=0;
	wire outclk_25, outclk_100, rst, gen_req, done_init_buf, data_valid, rden_rom, rden_fifo2, done_filt, done_gen, rd_clken;
	wire[DATA_WIDTH-1:0] rom_out_ff, fifo2_out_ff, fifo1_out_ff, new_pix, col,
	p1, p2, p3, p4, p5, p6, p7, p8, p9, vga_out;
	wire[DATA_WIDTH:0] row;
	wire[15:0] rd_addr;
	reg init_buff=0;
	reg[3:0] initial_delay=0;
	reg[7:0] seg1_wire, seg2_wire, seg3_wire, seg4_wire, seg5_wire, seg6_wire;
	reg[15:0] wr_addr=0;
	
	// PLL generates 100 MHz clock for image processing and 25 MHz clock
	// for VGA timing, input clock is 50 MHz from De10-Lite board
	PLL_cyc	PLL_inst (
		.refclk ( clk ),
		.rst(1'b0),
		.outclk_0 ( outclk_100 ),
		.outclk_1 ( outclk_25 )
	);

	// Switch debouncing for reset signal, only valid if high for 8ms
	rst_debounce rst_gen (
		.clk(outclk_100), 
		.rst_sync(rst_sync),
		.rst(rst)
	);

	// ROM and row buffers generation for image data
	fifo_rom_v2 memory_buffer (
		.clk(outclk_100), 
		.rst(rst),
		.init_buff(init_buff), 
		.gen_req(gen_req),
		.rden_rom(rden_rom), 
		.rden_fifo2(rden_fifo2), 
		.rom_out_ff(rom_out_ff), 
		.fifo1_out_ff(fifo1_out_ff), 
		.fifo2_out_ff(fifo2_out_ff),
		.data_valid(data_valid), 
		.done_init_buf(done_init_buf)
	);

	// Window generation from row buffers and ROM
	win_gen window_generation (.gen_ready(done_init_buf), 
		.gen_req(gen_req), 
		.clk(outclk_100), 
		.rst(rst),
		.rden_rom(rden_rom), 
		.rden_fifo2(rden_fifo2), 
		.done_gen(done_gen), 
		.done_filt(done_filt), 
		.data_valid(data_valid),
		.row1_out_ff(fifo2_out_ff), 
		.row2_out_ff(fifo1_out_ff), 
		.rom_out_ff(rom_out_ff), 
		.row(row), 
		.col(col),
		.p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7), .p8(p8), .p9(p9)
	);

	// Image filters
	`ifdef DUMMY_FILTER
		dummy_filter filter_module (
			.clk(outclk_100), 
			.rst(rst), 
			.done_gen(done_gen), 
			.p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7), .p8(p8), .p9(p9),
			.done_filt(done_filt), 
			.new_pix(new_pix)
		);
	`endif
	
	`ifdef MEDIAN_FILTER
		median_filter filter_module (
			.clk(outclk_100), 
			.rst(rst), 
			.done_gen(done_gen), 
			.p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7), .p8(p8), .p9(p9),
			.done_filt(done_filt), 
			.new_pix(new_pix)
		);
	`endif

	`ifdef MEAN_FILTER
		mean_filter filter_module (
			.clk(outclk_100), 
			.rst(rst), 
			.done_gen(done_gen), 
			.p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7), .p8(p8), .p9(p9),
			.done_filt(done_filt), 
			.new_pix(new_pix)
		);
	`endif
	
	`ifdef BILATERAL_FILTER
		bilateral_filter filter_module (
			.clk(outclk_100), 
			.rst(rst), 
			.done_gen(done_gen),
			.p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7), .p8(p8), .p9(p9),
			.done_filt(done_filt), 
			.new_pix(new_pix)
		);
	`endif

	DPRAM new_image_buffer (
		.data ( new_pix_ff ),
		.rd_aclr ( rst ),
		.rdaddress ( rd_addr ),
		.rdclock ( outclk_25 ),
		.rdclocken ( rd_clken ),
		.wraddress ( wr_addr ),
		.wrclock ( outclk_100 ),
		.wren ( done_filt_ff ),
		.q ( vga_out )
	);

	vga_controller VGA_u0 (
		.clk_25(outclk_25),
		.rst(rst),
		.rd_start(done_init_buf),
		.dpram_in(vga_out),
		.H_SYNC(VGA_HS),
		.V_SYNC(VGA_VS),
		.BLANK_N(VGA_BLANK_N),
		.SYNC_N(VGA_SYNC_N),
		.VGA_CLK(VGA_CLK),
		.rd_clken(rd_clken),
		.R(VGA_R),
		.G(VGA_G),
		.B(VGA_B),
		.rd_addr(rd_addr)
	);
	
	always @(posedge outclk_100) begin
		if (rst) begin
			init_buff <= 1'b0;
			initial_delay <= 4'd0;
			wr_addr <= 'd0;
			done_filt_ff <= 1'b0;
			new_pix_ff <= 'd0;
		end
		else if (initial_delay < 4'd7) begin
			init_buff <= 1'b0;
			initial_delay <= initial_delay + 1'b1;
		end
		else begin
			wr_addr <= (done_filt_ff) ? wr_addr + 1'b1 : wr_addr;
			done_filt_ff <= done_filt;
			new_pix_ff <= new_pix;
			init_buff <= (initial_delay == 4'd15) ? 1'b0 : 1'b1;
			initial_delay <= (initial_delay == 4'd15) ? initial_delay : initial_delay + 1'b1;
		end
	end
	
	// 7-segments display for debugging
	always @(*) begin
		case (new_pix_ff[3:0]) 
			4'd0: seg1_wire = 8'hc0;
			4'd1: seg1_wire = 8'hf9;
			4'd2: seg1_wire = 8'ha4;
			4'd3: seg1_wire = 8'hb0;
			4'd4: seg1_wire = 8'h99;
			4'd5: seg1_wire = 8'h92;
			4'd6: seg1_wire = 8'h82;
			4'd7: seg1_wire = 8'hf8;
			4'd8: seg1_wire = 8'h80;
			4'd9: seg1_wire = 8'h98;
			4'd10: seg1_wire = 8'h88;
			4'd11: seg1_wire = 8'h83;
			4'd12: seg1_wire = 8'hc6;
			4'd13: seg1_wire = 8'ha1;
			4'd14: seg1_wire = 8'h86;
			4'd15: seg1_wire = 8'h8e;
			default: seg1_wire = 8'hff;
		endcase
	end
	always @(*) begin
		case (new_pix_ff[7:4]) 
			4'd0: seg2_wire = 8'hc0;
			4'd1: seg2_wire = 8'hf9;
			4'd2: seg2_wire = 8'ha4;
			4'd3: seg2_wire = 8'hb0;
			4'd4: seg2_wire = 8'h99;
			4'd5: seg2_wire = 8'h92;
			4'd6: seg2_wire = 8'h82;
			4'd7: seg2_wire = 8'hf8;
			4'd8: seg2_wire = 8'h80;
			4'd9: seg2_wire = 8'h98;
			4'd10: seg2_wire = 8'h88;
			4'd11: seg2_wire = 8'h83;
			4'd12: seg2_wire = 8'hc6;
			4'd13: seg2_wire = 8'ha1;
			4'd14: seg2_wire = 8'h86;
			4'd15: seg2_wire = 8'h8e;
			default: seg2_wire = 8'hff;
		endcase
	end

	always @(*) begin
		case (col[3:0]) 
			4'd0: seg3_wire = 8'hc0;
			4'd1: seg3_wire = 8'hf9;
			4'd2: seg3_wire = 8'ha4;
			4'd3: seg3_wire = 8'hb0;
			4'd4: seg3_wire = 8'h99;
			4'd5: seg3_wire = 8'h92;
			4'd6: seg3_wire = 8'h82;
			4'd7: seg3_wire = 8'hf8;
			4'd8: seg3_wire = 8'h80;
			4'd9: seg3_wire = 8'h98;
			4'd10: seg3_wire = 8'h88;
			4'd11: seg3_wire = 8'h83;
			4'd12: seg3_wire = 8'hc6;
			4'd13: seg3_wire = 8'ha1;
			4'd14: seg3_wire = 8'h86;
			4'd15: seg3_wire = 8'h8e;
			default: seg3_wire = 8'hff;
		endcase
	end
	always @(*) begin
		case (col[7:4]) 
			4'd0: seg4_wire = 8'hc0;
			4'd1: seg4_wire = 8'hf9;
			4'd2: seg4_wire = 8'ha4;
			4'd3: seg4_wire = 8'hb0;
			4'd4: seg4_wire = 8'h99;
			4'd5: seg4_wire = 8'h92;
			4'd6: seg4_wire = 8'h82;
			4'd7: seg4_wire = 8'hf8;
			4'd8: seg4_wire = 8'h80;
			4'd9: seg4_wire = 8'h98;
			4'd10: seg4_wire = 8'h88;
			4'd11: seg4_wire = 8'h83;
			4'd12: seg4_wire = 8'hc6;
			4'd13: seg4_wire = 8'ha1;
			4'd14: seg4_wire = 8'h86;
			4'd15: seg4_wire = 8'h8e;
			default: seg4_wire = 8'hff;
		endcase
	end
	always @(*) begin
		case (row[3:0]) 
			4'd0: seg5_wire = 8'hc0;
			4'd1: seg5_wire = 8'hf9;
			4'd2: seg5_wire = 8'ha4;
			4'd3: seg5_wire = 8'hb0;
			4'd4: seg5_wire = 8'h99;
			4'd5: seg5_wire = 8'h92;
			4'd6: seg5_wire = 8'h82;
			4'd7: seg5_wire = 8'hf8;
			4'd8: seg5_wire = 8'h80;
			4'd9: seg5_wire = 8'h98;
			4'd10: seg5_wire = 8'h88;
			4'd11: seg5_wire = 8'h83;
			4'd12: seg5_wire = 8'hc6;
			4'd13: seg5_wire = 8'ha1;
			4'd14: seg5_wire = 8'h86;
			4'd15: seg5_wire = 8'h8e;
			default: seg5_wire = 8'hff;
		endcase
	end
	always @(*) begin
		case (row[7:4]) 
			4'd0: seg6_wire = 8'hc0;
			4'd1: seg6_wire = 8'hf9;
			4'd2: seg6_wire = 8'ha4;
			4'd3: seg6_wire = 8'hb0;
			4'd4: seg6_wire = 8'h99;
			4'd5: seg6_wire = 8'h92;
			4'd6: seg6_wire = 8'h82;
			4'd7: seg6_wire = 8'hf8;
			4'd8: seg6_wire = 8'h80;
			4'd9: seg6_wire = 8'h98;
			4'd10: seg6_wire = 8'h88;
			4'd11: seg6_wire = 8'h83;
			4'd12: seg6_wire = 8'hc6;
			4'd13: seg6_wire = 8'ha1;
			4'd14: seg6_wire = 8'h86;
			4'd15: seg6_wire = 8'h8e;
			default: seg6_wire = 8'hff;
		endcase
	end

	// 7-segments display for debugging and tracking valid reset signal
	assign seg1 = seg1_wire;
	assign seg2 = seg2_wire;
	assign seg3 = seg3_wire;
	assign seg4 = seg4_wire;
	assign seg5 = seg5_wire;
	assign seg6 = seg6_wire;
	assign rst_valid = rst;
endmodule

