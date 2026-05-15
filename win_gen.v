module win_gen(gen_ready, gen_req, done_gen, done_filt, data_valid,
	rden_rom, rden_fifo2, clk, rst, row1_out_ff, row2_out_ff, rom_out_ff, row, col,
	p1, p2, p3, p4, p5, p6, p7, p8, p9
);
	`include "parameters.vh"
	input clk, rst, gen_ready, done_filt, data_valid; //gen_ready = done_init_buf
	input[DATA_WIDTH-1:0] row1_out_ff, row2_out_ff, rom_out_ff;
	output gen_req, done_gen, rden_rom, rden_fifo2;
	output[DATA_WIDTH-1:0] p1, p2, p3, p4, p5, p6, p7, p8, p9, row, col;
	wire done_gen, rden_rom, rden_fifo2;
	reg gen_req;
	reg[1:0] counter;
	reg[2:0] state, next_state;
	reg[DATA_WIDTH-1:0] p1, p2, p3, p4, p5, p6, p7, p8, p9, row, col;
	localparam[7:0] MAX_COL = 8'd255, MAX_ROW = 8'd255;
	localparam[2:0] WAIT_INIT = 3'd0, INITREQ = 3'd1, WAITBUF = 3'd2, REQBUF = 3'd3, DONE_GEN = 3'd4, WAIT_FILT = 3'd5;
	
	// Next state combinational logic
	always @(*) begin
		case (state)
			WAIT_INIT: next_state = (gen_ready) ? (INITREQ) : (WAIT_INIT);
			INITREQ: next_state = WAITBUF;
			WAITBUF: next_state = (data_valid || (col == 8'd0 && counter == 2'd0) || 
				(col == MAX_COL && counter == 2'd2)) ? (REQBUF) : (WAITBUF);
			REQBUF: next_state = (counter < 2'd2) ? (WAITBUF) : (DONE_GEN);
			DONE_GEN: next_state = WAIT_FILT;
			WAIT_FILT: next_state = (done_filt) ? ((col == 8'd0) ? (INITREQ) : (REQBUF)) : (WAIT_FILT);
			default: next_state = WAIT_INIT;
		endcase
	end
	// State output for registers (Counters and pixel tracking)
	always @(posedge clk) begin
		case (state)
			WAIT_INIT: begin
				counter <= 2'd0;
				col <= 8'd0;
				row <= 8'd0;
			end
			INITREQ: begin
			end
			WAITBUF: begin
				if (next_state == REQBUF) begin
					if (data_valid) begin
						p9 <= rom_out_ff;
						p8 <= p9;
						p7 <= p8;
						p6 <= row2_out_ff;
						p5 <= p6;
						p4 <= p5;
						p3 <= row1_out_ff;
						p2 <= p3;
						p1 <= p2;
					end
					else begin
						p9 <= 8'd0;
						p8 <= p9;
						p7 <= p8;
						p6 <= 8'd0;
						p5 <= p6;
						p4 <= p5;
						p3 <= 8'd0;
						p2 <= p3;
						p1 <= p2;
					end
				end
			end
			REQBUF: begin
				counter <= counter + 1'b1;
			end
			DONE_GEN: begin
				counter <= (col == MAX_COL) ? (8'd0) : (counter - 2'd2);
				col <= col + 1'b1;
				row <= (col == MAX_COL) ? (row + 1'b1) : row;
			end
			WAIT_FILT: begin
			end
			default: begin
				counter <= counter;
				row <= row;
				col <= col;
				p1 <= p1;
				p2 <= p2;
				p3 <= p3;
				p4 <= p4;
				p5 <= p5;
				p6 <= p6;
				p7 <= p7;
				p8 <= p8;
				p9 <= p9;
			end
		endcase
	end

	// Load next state into state register
	always @(posedge clk) begin
		if (rst) begin
			state <= WAIT_INIT;
		end
		else begin
			state <= next_state;
		end
	end

	// gen_req output using always_comb block
	always @(*) begin
		case (state)
			WAIT_INIT: gen_req = 1'b0;
			INITREQ: begin
				gen_req = (col == 8'd0) ? (1'b0) : (1'b1);
			end
			WAITBUF: gen_req = 1'b0;
			REQBUF: begin
				gen_req = (counter == 2'd1 && col == MAX_COL) ? (1'b0) : 
					((counter == 2'd2) ? (1'b0) : (1'b1));
			end
			DONE_GEN: gen_req = 1'b0;
			WAIT_FILT: gen_req = 1'b0;
			default: gen_req = 1'b0;
		endcase
	end

	// ROM read-enable and window generation finish signals output logic
	assign rden_fifo2 = (row == 8'd0) ? (1'b0) : (1'b1);
	assign rden_rom = (row == MAX_ROW) ? (1'b0) : (1'b1);
	assign done_gen = (state == DONE_GEN) ? (1'b1) : (1'b0);

endmodule

