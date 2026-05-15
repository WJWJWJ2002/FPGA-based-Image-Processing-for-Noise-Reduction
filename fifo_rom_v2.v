module fifo_rom_v2 (clk, rst, init_buff, rden_rom, rden_fifo2, gen_req, 
	rom_out_ff, fifo1_out_ff, fifo2_out_ff, data_valid, done_init_buf
);
	`include "parameters.vh"
	input clk, rst, init_buff, gen_req, rden_rom, rden_fifo2;
	output data_valid, done_init_buf;
	output[DATA_WIDTH-1:0] rom_out_ff, fifo1_out_ff, fifo2_out_ff;
	reg rdrow2, rdrow1, wrrow1, wrrow2, data_valid;
	reg[MEM_BITS-1:0] addr;
	reg[DATA_WIDTH-1:0] rom_out_ff, fifo1_out_ff, fifo2_out_ff;
	wire done_init_buf, emptyrow2, fullrow2, emptyrow1, fullrow1;
	wire[FIFO_BITS-1:0] bufw2, bufw1;
	wire[DATA_WIDTH-1:0] rom_out, fifo1_out, fifo2_out;
	reg[1:0] wrcount;
	reg[2:0] state, next_state;
	localparam[2:0] INIT = 3'd0, WRITE = 3'd1, DONE = 3'd2, RDBUF = 3'd3,
		WAIT_FF = 3'd4, WRBUF = 3'd5, VALID = 3'd6, WAIT_REQ = 3'd7;
	rom img_data (.clock(clk), .address(addr), .rden(rden_rom), .q(rom_out));
	
	//ROM_out is third row
	fifo row2 (.clock(clk), 
	.data(rom_out_ff), 
	.rdreq ( rdrow2 ),
	.wrreq ( wrrow2 ),
	.empty ( emptyrow2 ), 
	.full ( fullrow2 ),
	.q ( fifo1_out ),
	.usedw ( bufw2 ),
	.sclr(rst)
	);
	
	fifo row1 (.clock(clk), 
	.data(fifo1_out_ff), 
	.rdreq ( rdrow1 ),
	.wrreq ( wrrow1 ),
	.empty ( emptyrow1 ), 
	.full ( fullrow1 ),
	.q ( fifo2_out ),
	.usedw ( bufw1 ),
	.sclr (rst)
	);
	
	initial begin
		state <= INIT;
		next_state <= INIT;
	end

	// Next state logic
	always @(*) begin
		case (state) 
			INIT: next_state = (init_buff) ? WRITE : INIT;
			WRITE: begin
				if (fullrow2) next_state = DONE;
				else next_state = WRITE;
			end
			DONE: next_state = (gen_req) ? (RDBUF) : (DONE);
			RDBUF: next_state = WAIT_FF;
			WAIT_FF: next_state = WRBUF;
			WRBUF: next_state = VALID;
			VALID: next_state = WAIT_REQ;
			WAIT_REQ: next_state = (gen_req) ? (RDBUF) : (WAIT_REQ);
			default: next_state = INIT;
		endcase
	end

	// Control signals generation for buffers and filter window generation module
	always @(*) begin
		case (state)
			INIT: begin
				wrrow2 = 1'b0;
				rdrow2 = 1'b0;
				wrrow1 = 1'b0;
				rdrow1 = 1'b0;
				data_valid = 1'b0;
			end
			WRITE: begin
				if (wrcount > 2'd2 && !fullrow2) begin
					wrrow2 = 1'b1;
				end
				else begin
					wrrow2 = 1'b0;
				end
				wrrow1 = 1'b0;
				rdrow1 = 1'b0;
				rdrow2 = 1'b0;
				data_valid = 1'b0;
			end
			DONE: begin
				wrrow1 = 1'b0;
				wrrow2 = 1'b0;
				data_valid = 1'b0;
				rdrow1 = 1'b0;
				rdrow2 = 1'b0;
			end
			RDBUF: begin
				rdrow1 = (rden_fifo2) ? (1'b1) : (1'b0);
				rdrow2 = 1'b1;
				data_valid = 1'b0;
				wrrow1 = 1'b0;
				wrrow2 = 1'b0;
			end
			WAIT_FF: begin
				rdrow1 = 1'b0;
				rdrow2 = 1'b0;
				wrrow1 = 1'b0;
				wrrow2 = 1'b0;
				data_valid = 1'b0;
			end
			WRBUF: begin
				wrrow1 = 1'b1;
				wrrow2 = 1'b0;
				rdrow1 = 1'b0;
				rdrow2 = 1'b0;
				data_valid = 1'b0;
			end
			VALID: begin
				data_valid = 1'b1;
				wrrow1 = 1'b0;
				wrrow2 = 1'b1;
				rdrow1 = 1'b0;
				rdrow2 = 1'b0;
			end
			WAIT_REQ: begin
				data_valid = 1'b0;
				wrrow1 = 1'b0;
				wrrow2 = 1'b0;
				rdrow1 = 1'b0;
				rdrow2 = 1'b0; 
			end
			default: begin
				wrrow1 = 1'b0;
				wrrow2 = 1'b0;
				data_valid = 1'b0;
				rdrow2 = 1'b0;
				rdrow1 = 1'b0;
			end
		endcase
	end
	
	// Buffer to solve setup timing issue
	always @(posedge clk) begin
		rom_out_ff <= (rden_rom) ? rom_out : 8'd0;
		fifo1_out_ff <= fifo1_out;
		fifo2_out_ff <= fifo2_out;
	end
	
	// Delays computation buffers initialization and ROM address tracking
	always @(posedge clk) begin
		case (state)
			INIT: begin
				wrcount <= 2'd0;
				addr <= 16'd0;
			end
			WRITE: begin
				if (wrcount < 2'd3)
					wrcount <= wrcount + 1'b1;
				else
					wrcount = wrcount;
				if (bufw2 <= FIFO_DEPTH - 4 && !fullrow2)
					addr <= addr + 1'b1;
				else 
					addr <= addr;
			end
			DONE: begin
				wrcount <= 2'd0;
			end
			RDBUF: begin
				addr <= (rden_rom) ? addr + 1'b1 : addr;
			end
			default: begin
				addr <= addr;
				wrcount <= 2'd0;
			end
		endcase
	end


	// State transition
	always @(posedge clk) begin
		if (rst) begin
			state <= INIT;
		end
		else begin
			state <= next_state;
		end
	end

	assign done_init_buf = (state == DONE) ? (1'b1) : (1'b0);
endmodule
