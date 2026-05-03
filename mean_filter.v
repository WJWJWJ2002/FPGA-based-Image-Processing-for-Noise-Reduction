module mean_filter(clk, done_gen, done_filt, new_pix, p1, p2, p3, p4, p5, p6, p7, p8, p9);
	`include "parameters.vh"
	input clk, done_gen;
	input[DATA_WIDTH-1:0] p1, p2, p3, p4, p5, p6, p7, p8, p9;
	output done_filt;
	output[DATA_WIDTH-1:0] new_pix;
	reg[2:0] div_delay;
	reg[DATA_WIDTH-1:0] a11, a12, a13, a21, a22, a23, a31, a32, a33, mean_pix_ff;
	reg[8:0] sum0, sum1, sum2, sum3;
	reg[9:0] sum4, sum5; 
	reg[11:0] sum6;
	wire done_filt, en_div;
	wire[DATA_WIDTH-1:0] new_pix, mean_pix;
	reg[2:0] state, next_state;
	localparam[2:0] WAIT_GEN = 3'd0, S1 = 3'd1, S2 = 3'd2, S3 = 3'd3, S4 = 3'd4, DONE = 3'd5; 
	
	always @(*) begin
		case (state)
			WAIT_GEN: next_state = (done_gen) ? S1 : WAIT_GEN;
			S1: next_state = S2;
			S2: next_state = S3;
			S3: next_state = S4;
			S4: next_state = (div_delay < 3'd3) ? S4 : DONE;
			DONE: next_state = WAIT_GEN;
			default: next_state = WAIT_GEN;
		endcase
	end
			
	Divider	Divider_inst (
		.clken ( en_div ),
		.clock ( clk ),
		.denom ( 4'd9 ),
		.numer ( sum6 ),
		.quotient ( mean_pix ),
		.remain (  )
	);

	always @(posedge clk) begin
		case (state)
			WAIT_GEN: begin
				div_delay <= 3'd0;
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
				sum0 <= a11 + a12;
				sum1 <= a13 + a21;
				sum2 <= a23 + a31;
				sum3 <= a32 + a33;
			end
			S2: begin
				sum4 <= sum0 + sum1;
				sum5 <= sum2 + sum3;
			end
			S3: begin
				sum6 <= sum4 + sum5 + a22;
			end
			S4: begin
				div_delay <= div_delay + 1'b1;
			end
			DONE: begin
				div_delay <= 3'd0;
			end
			default: begin
			end
		endcase
	end

	always @(posedge clk) begin
		state <= next_state;
		mean_pix_ff <= mean_pix;
	end
	
	assign en_div = (state == S4) ? (1'b1) : (1'b0);
	assign new_pix = mean_pix_ff;
	assign done_filt = (state == DONE) ? (1'b1) : (1'b0);
endmodule

