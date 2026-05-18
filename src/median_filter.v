module median_filter(clk, rst, done_gen, done_filt, new_pix, p1, p2, p3, p4, p5, p6, p7, p8, p9);
	`include "parameters.vh"
	input clk, rst, done_gen;
	input[DATA_WIDTH-1:0] p1, p2, p3, p4, p5, p6, p7, p8, p9;
	output done_filt;
	output[DATA_WIDTH-1:0] new_pix;
	reg[DATA_WIDTH-1:0] a11, a12, a13, a21, a22, a23, a31, a32, a33;
	wire done_filt;
	wire[DATA_WIDTH-1:0] new_pix;
	reg[3:0] state, next_state;
	localparam[3:0] WAIT_GEN = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3, S4 = 4'd4, S5 = 4'd5, S6 = 4'd6, S7 = 4'd7, 
		S8 = 4'd8, S9 = 4'd9, S10 = 4'd10, DONE = 4'd11; 
	
	// Next state logic
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

	// ALG1 median filter
	always @(posedge clk) begin
		case (state)
			WAIT_GEN: begin
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
			S1: begin
				if (a11 > a23) begin
					a23 <= a11;
					a11 <= a23;
				end
				if (a12 > a31) begin
					a31 <= a12;
					a12 <= a31;
				end
				if (a13 > a32) begin
					a32 <= a13;
					a13 <= a32;
				end
				if (a21 > a33) begin
					a33 <= a21;
					a21 <= a33;
				end
			end
			S2: begin
				if (a23 > a32) begin
					a32 <= a23;
					a23 <= a32;
					a12 <= a21;
					a21 <= a12;
				end
				if (a31 > a33) begin
					a33 <= a31;
					a31 <= a33;
					a11 <= a13;
					a13 <= a11;
				end
			end
			S3: begin
				if (a32 > a33) begin
					a33 <= a32;
					a32 <= a33;
					a23 <= a31;
					a31 <= a23;
					a13 <= a21;
					a21 <= a13;
					a11 <= a12;
					a12 <= a11;
				end
			end
			S4: begin
				if (a31 > a32) begin
					a32 <= a31;
					a31 <= a32;
					a12 <= a13;
					a13 <= a12;
				end
				if (a21 > a22) begin
					a22 <= a21;
					a21 <= a22;
				end
			end
			S5: begin
				if (a23 > a31) begin
					a23 <= a31;
					a31 <= a23;
					a11 <= a12;
					a12 <= a11;
				end
				if (a13 > a22) begin
					a22 <= a13;
					a13 <= a22;
				end
			end
			S6: begin
				if (a22 > a31) begin
					a22 <= a31;
					a31 <= a22;
					a12 <= a13;
					a13 <= a12;
				end
			end
			S7: begin
				if (a22 > a23) begin
					a23 <= a22;
					a22 <= a23;
					a11 <= a13;
					a13 <= a11;
				end
				if (a12 > a21) begin
					a12 <= a21;
					a21 <= a12;
				end
			end
			S8: begin
				if (a21 > a23) begin
					a23 <= a21;
					a21 <= a23;
					a11 <= a12;
					a12 <= a11;
				end
			end
			S9: begin
				if (a21 > a22) begin
					//a22 <= a21;
					//a21 <= a22;
					a22 <= a21;
					a21 <= a22;
					a12 <= a13;
					a13 <= a12;
				end
			end
			S10: begin 
				if (a11 > a22) begin
					a11 <= a22;
					a22 <= a11;
				end
			end
			DONE: begin
			end
			default: begin
			end
		endcase
	
	end		
	// State register loading
	always @(posedge clk) begin
		if (rst) begin
			state <= WAIT_GEN;
		end
		else begin
			state <= next_state;
		end
	end

	// Median filter output, finish filtering signal
	assign new_pix = a22;
	assign done_filt = (state == DONE) ? (1'b1) : (1'b0);
endmodule

