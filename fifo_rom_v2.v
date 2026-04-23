module fifo_rom_v2 (clk, init_buff, done_init_buf, rden_rom, gen_req, rom_out_ff, fifo1_out_ff, fifo2_out_ff, data_valid, done_init_buf
);
	`include "parameters.vh"
	input clk, init_buff, gen_req, rden_rom;
	output data_valid, done_init_buf;
	output[DATA_WIDTH-1:0] rom_out_ff, fifo1_out_ff, fifo2_out_ff;
	reg done_init_buf, rdrow2, rdrow1, wrrow1, wrrow2, data_valid;
	reg[MEM_BITS-1:0] addr = 'd0;
	reg[DATA_WIDTH-1:0] rom_out_ff, fifo1_out_ff, fifo2_out_ff;
	wire emptyrow1, fullrow1, emptyrow2, fullrow2;
	wire[FIFO_BITS-1:0] bufw1, bufw2;
	wire[DATA_WIDTH-1:0] rom_out, fifo1_out, fifo2_out;
	reg[1:0] delay1, delay2, wrcount;
	reg[1:0] state, next_state;
	localparam[2:0] INIT = 2'd0, WRITE = 2'd1, DONE = 2'd2, READ_WRITE = 2'd3, 
		CYCLE1 = 2'd4, CYCLE2 = 2'd5, CYCLE3 = 2'd6, WAIT = 2'd7;
	//parameter DATA_WIDTH = 8, MEM_BITS = 16, FIFO_BITS = 8;
	rom img_data (.clock(clk), .address(addr), .rden(rden_rom), .q(rom_out));
	
	//ROM_out is third row
	fifo row2 (.clock(clk), 
	.data(rom_out_ff), 
	.rdreq ( rdrow2 ),
	.wrreq ( wrrow2 ),
	.empty ( emptyrow1 ), 
	.full ( fullrow1 ),
	.q ( fifo1_out ),
	.usedw ( bufw1 )
	);
	
	fifo row1 (.clock(clk), 
	.data(fifo1_out_ff), 
	.rdreq ( rdrow1 ),
	.wrreq ( wrrow1 ),
	.empty ( emptyrow2 ), 
	.full ( fullrow2 ),
	.q ( fifo2_out ),
	.usedw ( bufw2 )
	);
	
	initial begin
		state <= INIT;
		next_state <= INIT;
		wrcount <= 1'b0;
		rdrow2 <= 1'b0;
		wrrow2 <= 1'b0;
		rdrow1 <= 1'b0;
		wrrow1 <= 1'b0;
		delay1 <= 2'b00;
		done_init_buf <= 1'b0;
	end

	// Next state logic
	always @(*) begin
		case (state) 
			INIT: next_state = (init_buff) ? WRITE : INIT;
			WRITE: begin
				if (fullrow1) next_state = READ_WRITE;
				else next_state = WRITE;
			end
			DONE: next_state = (gen_req) ? (DONE) : (DONE);
			READ_WRITE: begin
				next_state = (delay2 >= 2'd1) ? (DONE) : (READ_WRITE);
			end
			default: next_state = INIT;
		endcase
	end

	// Control signals generation 
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
				if (wrcount > 2'd2 && !fullrow1) begin
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
			READ_WRITE: begin
				wrrow1 = 1'b0;
				wrrow2 = 1'b0;
				rdrow1 = 1'b0;
				if (!emptyrow1) begin
					rdrow2 = 1'b1;
				end
				else begin
					rdrow2 = 1'b0;
				end

				if (delay1 < 2'd2) begin
					data_valid = 1'b0;
				end
				else begin
					data_valid = 1'b1;
				end
			end
			DONE: begin
				wrrow1 = 1'b0;
				wrrow2 = 1'b0;
				data_valid = 1'b0;
				rdrow1 = 1'b0;
				rdrow2 = 1'b0;
				done_init_buf = 1'b1;
			end
			default: begin
				wrrow1 = 1'b0;
				wrrow2 = 1'b0;
				data_valid = 1'b0;
				rdrow2 = 1'b0;
				rdrow1 = 1'b0;
				done_init_buf = 1'b0;
			end
		endcase
	end
	
	// Buffer to solve setup timing issue
	always @(posedge clk) begin
		rom_out_ff <= rom_out;
		fifo1_out_ff <= fifo1_out;
		fifo2_out_ff <= fifo2_out;
	end
	
	// Delays computation and ROM address tracking
	always @(posedge clk) begin
		case (state)
			INIT: begin
				wrcount <= 2'd0;
				addr <= 16'd0;
				delay1 <= 2'd0;
				delay2 <= 2'd0;
			end
			WRITE: begin
				if (wrcount < 2'd3)
					wrcount <= wrcount + 1'b1;
				else
					wrcount = wrcount;
				if (bufw1 <= FIFO_DEPTH - 4 && !fullrow1)
					addr <= addr + 1'b1;
				else 
					addr <= addr;
			end
			READ_WRITE: begin
				if (delay1 < 2'd2)
					delay1 <= delay1 + 1'b1;
				else 
					delay1 <= delay1;

				if (emptyrow1) 
					delay2 <= delay2 + 1'b1;
			end
		endcase
	end


	// State transition
	always @(posedge clk) begin
		state <= next_state;
	end
endmodule
