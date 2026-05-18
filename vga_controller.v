module vga_controller(
	input clk_25,
	input rst,
	input rd_start,
	input[7:0] dpram_in,
	output rd_clken,
	output reg H_SYNC,
	output reg V_SYNC,
	output[3:0] R, G, B,
	output reg[15:0] rd_addr
);
	localparam[1:0] WAIT_FILT = 2'd0, VGA_WAIT = 2'd1, VGA_START = 2'd2;
	reg[1:0] state=WAIT_FILT;
	reg[16:0] delay=0;
	reg[9:0] x_count=0, y_count=0;

	always @(posedge clk_25) begin
		if (rst) begin
			state <= WAIT_FILT;
			rd_addr <= 'd0;
			x_count <= 'd0;
			y_count <= 'd0;
			delay <= 'd0;
			H_SYNC <= 1'b0;
			V_SYNC <= 1'b0;
		end
		else begin
			if (state == WAIT_FILT) begin
				x_count <= 'd0;
				y_count <= 'd0;
				rd_addr <= 'd0;
				state <= (rd_start) ? VGA_WAIT : WAIT_FILT;
				H_SYNC <= 1'b0;
				V_SYNC <= 1'b0;
			end
			else if (state == VGA_WAIT) begin
				H_SYNC <= 1'b0;
				V_SYNC <= 1'b0;
				delay <= (delay == 17'd125000) ? 'd0 : delay + 1'b1;
				state <= (delay == 17'd125000) ? VGA_START : VGA_WAIT;
			end
			else begin
				H_SYNC <= (x_count < 'd655 || x_count > 'd751) ? 1'b1 : 1'b0;
				V_SYNC <= (y_count < 'd489 || y_count > 'd491) ? 1'b1 : 1'b0;
				rd_addr <= (x_count < 'd256 && y_count < 'd256) ? 
					rd_addr + 1'b1 : ((y_count > 'd255) ? 'd0 : rd_addr);
				x_count <= (x_count == 'd799) ? 'd0 : x_count + 1'b1;
				y_count <= (x_count == 'd799) ? ((y_count == 'd524) ? 'd0 : y_count + 1'b1) : y_count;
				state <= VGA_START;
			end
		
		end
	end
	
	assign rd_clken = (x_count <= 'd256 && y_count < 'd256 && ~rst && state == VGA_START) ? 1'b1 : 1'b0;
	assign R = dpram_in[7:4] & {4{rd_clken}};
	assign G = dpram_in[7:4] & {4{rd_clken}};
	assign B = dpram_in[7:4] & {4{rd_clken}};

endmodule

