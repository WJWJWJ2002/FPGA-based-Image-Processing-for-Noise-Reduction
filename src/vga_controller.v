module vga_controller(
	input clk_25,
	input rst,
	input rd_start,
	input[7:0] dpram_in,
	output rd_clken,
	output reg H_SYNC,
	output reg V_SYNC,
	output SYNC_N,
	output BLANK_N,
	output VGA_CLK,
	output[7:0] R, G, B,
	output reg[15:0] rd_addr
);
	
	reg[9:0] x_count=0, y_count=0;

	always @(posedge clk_25) begin
		H_SYNC <= (x_count < 'd655 || x_count > 'd751) ? 1'b1 : 1'b0;
		V_SYNC <= (y_count < 'd489 || y_count > 'd491) ? 1'b1 : 1'b0;
		rd_addr <= (x_count < 'd256 && y_count < 'd256) ? 
		rd_addr + 1'b1 : ((y_count > 'd255) ? 'd0 : rd_addr);
		x_count <= (x_count == 'd799) ? 'd0 : x_count + 1'b1;
		y_count <= (x_count == 'd799) ? ((y_count == 'd524) ? 'd0 : y_count + 1'b1) : y_count;
	end
	
	assign rd_clken = (x_count <= 'd256 && y_count < 'd256 && ~rst) ? 1'b1 : 1'b0;
	assign R = dpram_in[7:0] & {8{rd_clken}};
	assign G = dpram_in[7:0] & {8{rd_clken}};
	assign B = dpram_in[7:0] & {8{rd_clken}};
	assign BLANK_N = H_SYNC & V_SYNC;
	assign SYNC_N = 1'b0;
	assign VGA_CLK = clk_25;
endmodule

