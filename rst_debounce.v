module rst_debounce (input clk,
	input rst_sync,
	output wire rst
	);
	
	localparam[1:0] LOW = 2'd0, HIGH = 2'd1, WAIT_VALID = 2'd2, RESET = 2'd3;
	reg rst_reg=0, valid=0;
	reg[3:0] state=LOW, next_state=LOW;
	reg[19:0] count=0;
	always @(*) begin
		case (state)
			LOW: next_state = (rst_reg) ? WAIT_VALID : LOW;
			WAIT_VALID: next_state = (count == 20'd800_000) ? RESET : ((valid) ? WAIT_VALID : LOW);
			RESET: next_state = (rst_sync) ? RESET : LOW;
			default: next_state = LOW;
		endcase
	end

	always @(posedge clk) begin
		case (state)
			LOW: begin 
				rst_reg <= rst_sync;
				count <= 20'd0;
				valid <= 1'b1;
			end
			WAIT_VALID: begin
				count <= count + 1'b1;
				if (rst_sync == 1'b0) begin
					valid <= 1'b0;
				end
			end
			RESET: begin
				count <= 20'd0;
				rst_reg <= rst_sync;
			end
			default: begin
				rst_reg <= rst_sync;
				count <= 20'd0;
				valid <= 1'b1;
			end
		endcase
	end

	always @(posedge clk) begin
		state <= next_state;
	end

	assign rst = (state == RESET) ? 1'b1 : 1'b0;
endmodule

