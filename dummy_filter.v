module dummy_filter(clk, rst, done_gen, done_filt, new_pix, p1, p2, p3, p4, p5, p6, p7, p8, p9);
	input clk, rst, done_gen;
	input[7:0] p1, p2, p3, p4, p5, p6, p7, p8, p9;
	output done_filt;
	output[7:0] new_pix;
	reg[7:0] a11, a12, a13, a21, a22, a23, a31, a32, a33;
	wire done_filt;
	wire[7:0] new_pix;
	reg[3:0] state, next_state;
	localparam[3:0] WAIT_GEN = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3, S4 = 4'd4, S5 = 4'd5, S6 = 4'd6, S7 = 4'd7, 
		S8 = 4'd8, S9 = 4'd9, S10 = 4'd10, DONE = 4'd11; 
	
	always @(*) begin
		case (state)
			WAIT_GEN: next_state = (done_gen) ? S1 : WAIT_GEN;
			S1: next_state = S2;
			S2: next_state = S3;
			S3: next_state = S4;
			S4: next_state = S5;
			S5: next_state = S6;
			S6: next_state = S7;
			S7: next_state = S8;
			S8: next_state = S9;
			S9: next_state = S10;
			S10: next_state = DONE;
			DONE: next_state = WAIT_GEN;
			default: next_state = WAIT_GEN;
		endcase
	end
			
	always @(posedge clk) begin
		case (state)
			WAIT_GEN: begin
				if (rst) begin
					a11 <= 8'd0;
					a12 <= 8'd0;
					a13 <= 8'd0;
					a21 <= 8'd0;
					a22 <= 8'd0;
					a23 <= 8'd0;
					a31 <= 8'd0;
					a32 <= 8'd0;
					a33 <= 8'd0;
				end
				else begin
					a11 <= p1;
					a12 <= p2;
					a13 <= p3;
					a21 <= p4;
					a22 <= p5;
					a23 <= p6;
					a31 <= p7;
					a32 <= p8;
					a33 <= p9;
				end
			end
			S1: begin
			end
			S2: begin
			end
			S3: begin
			end
			S4: begin
			end
			S5: begin
			end
			S6: begin
			end
			S7: begin
			end
			S8: begin
			end
			S9: begin
			end
			S10: begin
			end
			DONE: begin
	
			end
		endcase
	end

	always @(posedge clk) begin
		if (rst) begin
			state <= WAIT_GEN;
		end
		else begin
			state <= next_state;
		end
	end

	assign new_pix = a22;
	assign done_filt = (state == DONE) ? (1'b1) : (1'b0);
endmodule

