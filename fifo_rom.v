module fifo_rom (clk, init_buff, done_init_buf, rden_rom, gen_req, rom_out_ff, fifo1_out_ff, fifo2_out_ff, addr, data_valid, done_init_buf
);
	`include "parameters.vh"
	input clk, init_buff, gen_req;
	output data_valid, done_init_buf;
	output[MEM_BITS-1:0] addr;
	output[DATA_WIDTH-1:0] rom_out_ff, fifo1_out_ff, fifo2_out_ff;
	reg done_init_buf, rdrow2, rdrow1, wrrow2, wrrow1, data_valid;
	reg[MEM_BITS-1:0] addr = 'd0;
	reg[DATA_WIDTH-1:0] rom_out_ff, fifo1_out_ff, fifo2_out_ff;
	wire emptyrow1, fullrow1, emptyrow2, fullrow2;
	wire[FIFO_BITS-1:0] bufw1, bufw2;
	wire[DATA_WIDTH-1:0] rom_out, fifo1_out, fifo2_out;
	reg[1:0] delay1, wrcount;
	reg[1:0] state, next_state;
	localparam[2:0] INIT = 2'd0, WRITE = 2'd1, DONE = 2'd2, READ_WRITE = 2'd3, 
		CYCLE1 = 2'd4, CYCLE2 = 2'd5, CYCLE3 = 2'd6, WAIT = 2'd7;
	//parameter DATA_WIDTH = 8, MEM_BITS = 16, FIFO_BITS = 8;
	rom img_data (.clock(clk), .address(addr), .rden(rden_rom), .q(rom_out));
	
	//ROM_out is third row
	fifo row2 (.clock(clk), 
	.data(rom_out_ff), 
	.rdreq ( rdrow2 ),
	.wrreq ( wrrow1 ),
	.empty ( emptyrow1 ), 
	.full ( fullrow1 ),
	.q ( fifo1_out ),
	.usedw ( bufw1 )
	);
	
	fifo row1 (.clock(clk), 
	.data(fifo1_out_ff), 
	.rdreq ( rdrow1 ),
	.wrreq ( wrrow2 ),
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
		wrrow1 <= 1'b0;
		rdrow1 <= 1'b0;
		wrrow2 <= 1'b0;
		delay1 <= 2'b00;
		done_init_buf <= 1'b0;
	end

	// State logic
	always @(*) begin
		case (state) 
			INIT: next_state = WRITE;
			WRITE: begin
				if (fullrow1) next_state = DONE;
				else next_state = WRITE;
			end
			DONE: next_state = (gen_req) ? (S1) : (DONE);
			READ_WRITE: begin
			end

			WAIT: next_state = (gen_req) ? CYCLE1 : WAIT;
			
			default: next_state = INIT;
		endcase
	end

	always @(posedge clk) begin
		case (state)
			WAIT: begin
			end
		endcase
	end

	// Computation of memory outputs
	always @(posedge clk) begin
		if (init_buff) begin
			case (state) 
				INIT: begin
					addr <= addr;
					wrrow1 <= 1'b0;
					rdrow2 <= 1'b0;
					wrrow2 <= 1'b0;
					rdrow1 <= 1'b0;
					//next_state <= WRITE;
				end
				WRITE: begin
					rom_out_ff   <= rom_out;
					fifo1_out_ff <= fifo1_out;
					fifo2_out_ff <= fifo2_out;
					//wrcount <= (wrcount == 1'b1) ? (wrcount) : (wrcount + 1'b1);
					if (wrcount == 2'd2) wrcount <= wrcount;
					else wrcount <= wrcount + 1'b1;
	
					if (wrcount < 2'd2) begin
						wrrow1 <= 1'b0;
						wrrow2 <= 1'b0;
						rdrow2 <= 1'b0;
						rdrow1 <= 1'b0;
						addr   <= addr + 1'b1;
					end
					else begin
						
						if (delay1 < 2'd3) begin
							wrrow1 	   <= 1'b1;
							rdrow2     <= 1'b1; 
							wrrow2     <= 1'b0;
							data_valid <= 1'b0;
							addr       <= addr + 1'b1;
							delay1     <= delay1 + 1'b1;
						end
						else begin
							if ((bufw1 == FIFO_DEPTH - 1) || fullrow1) wrrow1 <= 1'b0;
							else wrrow1 <= 1'b1;
		
							if ((bufw2 >= FIFO_DEPTH - 3) || fullrow2 || emptyrow1) rdrow2 <= 1'b0;
							else rdrow2 <= 1'b1;
		
							if ((bufw2 >= FIFO_DEPTH - 1) || fullrow2) wrrow2 <= 1'b0;
							else wrrow2 <= 1'b1;
		
							if ((bufw1 >= FIFO_DEPTH - 3) || fullrow1) addr <= addr;
							else addr <= addr + 1'b1;
		
						//	if (bufw2 <= FIFO_DEPTH - 2 && !fullrow2) data_valid <= 1'b1;
						//	else data_valid <= 1'b0;
						end
					
					end
				end
				DONE: begin
					//next_state <= WRITE;
					done_init_buf <= 1'b1;
					wrcount <= 2'd0;
					data_valid <= 1'b0;
					delay1 <= 2'd0;
				end
				READ_WRITE: begin
					
				end
			endcase
		end
		else if (gen_req) begin
			case (state)
				INIT: begin
					fifo2_out_ff <= fifo2_out;
					fifo1_out_ff <= fifo1_out;
					rom_out_ff <= rom_out;
					rdrow2 <= 1'b1;
					rdrow1 <= 1'b1;
					//addr <= (row == 0) ? addr : addr + 1'b1;
				end
			endcase
		end
	end
	// State transition
	always @(posedge clk) begin
		if ((init_buff && done_init_buf) || gen_req) begin
			state <= INIT;
		end
		else begin
			state <= next_state;
		end
	end
endmodule
