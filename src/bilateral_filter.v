module bilateral_filter(clk, rst, done_gen, done_filt, new_pix, p1, p2, p3, p4, p5, p6, p7, p8, p9);
	input clk, rst, done_gen;
	input[7:0] p1, p2, p3, p4, p5, p6, p7, p8, p9;
	output done_filt;
	output reg[7:0] new_pix;
	reg[6:0] ws11, ws12, ws13, ws21, ws22, ws23, ws31, ws32, ws33;
	reg[6:0] wr11, wr12, wr13, wr21, wr22, wr23, wr31, wr32, wr33;
	reg[7:0] a11, a12, a13, a21, a22, a23, a31, a32, a33;
	reg[7:0] diff_11, diff_12, diff_13, diff_21, diff_22, diff_23, diff_31, diff_32, diff_33;
	reg[7:0] d11_reg, d12_reg, d13_reg, d21_reg, d22_reg, d23_reg, d31_reg, d32_reg, d33_reg;
	wire[7:0] d11_div, d12_div, d13_div, d21_div, d23_div, d31_div, d32_div, d33_div;
	wire done_filt, en_div, en_mult_coeff, en_mult_pix, en_div_pix;
	wire[7:0] new_pix_v;
	wire[13:0] coeff_11, coeff_12, coeff_13, coeff_21, coeff_22, coeff_23, coeff_31, coeff_32, coeff_33;
	wire[21:0] cpp_11, cpp_12, cpp_13, cpp_21, cpp_22, cpp_23, cpp_31, cpp_32, cpp_33;
	reg[13:0] c11_reg, c12_reg, c13_reg, c21_reg, c22_reg, c23_reg, c31_reg, c32_reg, c33_reg;
	reg[15:0] c1_sum, c2_sum, c3_sum, c4_sum, c5_sum, c6_sum, coeff_sum;
	reg[21:0] cpp11_reg, cpp12_reg, cpp13_reg, cpp21_reg, cpp22_reg, cpp23_reg, cpp31_reg, cpp32_reg, cpp33_reg;
	reg[23:0] cpp1_sum, cpp2_sum, cpp3_sum, cpp4_sum, cpp5_sum, cpp6_sum, coepix_sum; 
	reg delay;
	reg[1:0] delay_coeff, delay_pix, div_delay;
	reg[3:0] divpix_delay;
	reg[3:0] state, next_state;
	localparam[3:0] WAIT_GEN = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3, S4 = 4'd4, S5 = 4'd5, S6 = 4'd6, S7 = 4'd7, 
		S8 = 4'd8, S9 = 4'd9, S10 = 4'd10, S11 = 4'd11, S12 = 4'd12, DONE = 4'd13; 

	scale_div	D11 (
		.clken ( en_div ),
		.clock ( clk ),
		.denom ( 2'd2 ),
		.numer ( diff_11 ),
		.quotient ( d11_div ),
		.remain (  )
	);

	scale_div	D12 (
		.clken ( en_div ),
		.clock ( clk ),
		.denom ( 2'd2 ),
		.numer ( diff_12 ),
		.quotient ( d12_div ),
		.remain (  )
	);
	scale_div	D13 (
		.clken ( en_div ),
		.clock ( clk ),
		.denom ( 2'd2 ),
		.numer ( diff_13 ),
		.quotient ( d13_div ),
		.remain (  )
	);
	scale_div	D21 (
		.clken ( en_div ),
		.clock ( clk ),
		.denom ( 2'd2 ),
		.numer ( diff_21 ),
		.quotient ( d21_div ),
		.remain (  )
	);
	scale_div	D23 (
		.clken ( en_div ),
		.clock ( clk ),
		.denom ( 2'd2 ),
		.numer ( diff_23 ),
		.quotient ( d23_div ),
		.remain (  )
	);
	scale_div	D31 (
		.clken ( en_div ),
		.clock ( clk ),
		.denom ( 2'd2 ),
		.numer ( diff_31 ),
		.quotient ( d31_div ),
		.remain (  )
	);
	scale_div	D32 (
		.clken ( en_div ),
		.clock ( clk ),
		.denom ( 2'd2 ),
		.numer ( diff_32 ),
		.quotient ( d32_div ),
		.remain (  )
	);
	scale_div	D33 (
		.clken ( en_div ),
		.clock ( clk ),
		.denom ( 2'd2 ),
		.numer ( diff_33 ),
		.quotient ( d33_div ),
		.remain (  )
	);
	MULT	COEFF11 (
		.clken ( en_mult_coeff ),
		.clock ( clk ),
		.dataa ( ws11 ),
		.datab ( wr11 ),
		.result ( coeff_11 )
	);
	MULT	COEFF12 (
		.clken ( en_mult_coeff ),
		.clock ( clk ),
		.dataa ( ws12 ),
		.datab ( wr12 ),
		.result ( coeff_12 )
	);
	MULT	COEFF13 (
		.clken ( en_mult_coeff ),
		.clock ( clk ),
		.dataa ( ws13 ),
		.datab ( wr13 ),
		.result ( coeff_13 )
	);
	MULT	COEFF21 (
		.clken ( en_mult_coeff ),
		.clock ( clk ),
		.dataa ( ws21 ),
		.datab ( wr21 ),
		.result ( coeff_21 )
	);
	MULT	COEFF22 (
		.clken ( en_mult_coeff ),
		.clock ( clk ),
		.dataa ( ws22 ),
		.datab ( wr22 ),
		.result ( coeff_22 )
	);
	MULT	COEFF23 (
		.clken ( en_mult_coeff ),
		.clock ( clk ),
		.dataa ( ws23 ),
		.datab ( wr23 ),
		.result ( coeff_23 )
	);
	MULT	COEFF31 (
		.clken ( en_mult_coeff ),
		.clock ( clk ),
		.dataa ( ws31 ),
		.datab ( wr31 ),
		.result ( coeff_31 )
	);
	MULT	COEFF32 (
		.clken ( en_mult_coeff ),
		.clock ( clk ),
		.dataa ( ws32 ),
		.datab ( wr32 ),
		.result ( coeff_32 )
	);
	MULT	COEFF33 (
		.clken ( en_mult_coeff ),
		.clock ( clk ),
		.dataa ( ws33 ),
		.datab ( wr33 ),
		.result ( coeff_33 )
	);
	MULT_PIX	PIX11 (
		.clken ( en_mult_pix ),
		.clock ( clk ),
		.dataa ( c11_reg ),
		.datab ( a11 ),
		.result ( cpp_11 )
	);
	MULT_PIX	PIX12 (
		.clken ( en_mult_pix ),
		.clock ( clk ),
		.dataa ( c12_reg ),
		.datab ( a12 ),
		.result ( cpp_12 )
	);
	MULT_PIX	PIX13 (
		.clken ( en_mult_pix ),
		.clock ( clk ),
		.dataa ( c13_reg ),
		.datab ( a13 ),
		.result ( cpp_13 )
	);
	MULT_PIX	PIX21 (
		.clken ( en_mult_pix ),
		.clock ( clk ),
		.dataa ( c21_reg ),
		.datab ( a21 ),
		.result ( cpp_21 )
	);
	MULT_PIX	PIX22 (
		.clken ( en_mult_pix ),
		.clock ( clk ),
		.dataa ( c22_reg ),
		.datab ( a22 ),
		.result ( cpp_22 )
	);
	MULT_PIX	PIX23 (
		.clken ( en_mult_pix ),
		.clock ( clk ),
		.dataa ( c23_reg ),
		.datab ( a23 ),
		.result ( cpp_23 )
	);
	MULT_PIX	PIX31 (
		.clken ( en_mult_pix ),
		.clock ( clk ),
		.dataa ( c31_reg ),
		.datab ( a31 ),
		.result ( cpp_31 )
	);
	MULT_PIX	PIX32 (
		.clken ( en_mult_pix ),
		.clock ( clk ),
		.dataa ( c32_reg ),
		.datab ( a32 ),
		.result ( cpp_32 )
	);
	MULT_PIX	PIX33 (
		.clken ( en_mult_pix ),
		.clock ( clk ),
		.dataa ( c33_reg ),
		.datab ( a33 ),
		.result ( cpp_33 )
	);
	Divider_pix Div_coeff (
		.clken (en_div_pix),
		.clock (clk),
		.denom (coeff_sum),
		.numer (coepix_sum),
		.quotient (new_pix_v),
		.remain ()
	);

	always @(*) begin
		case (state)
			WAIT_GEN: next_state = (done_gen) ? S1 : WAIT_GEN;
			S1: next_state = (delay < 1'b1) ? S1 : S2;
			S2: next_state = (div_delay < 2'd3) ? S2 : S3;
			S3: next_state = S4;
			S4: next_state = S5;
			S5: next_state = (delay_coeff < 2'd3) ? S5 : S6;
			S6: next_state = S7;
			S7: next_state = (delay_pix < 2'd3) ? S7 : S8;
			S8: next_state = S9;
			S9: next_state = S10;
			S10: next_state = S11;
			S11: next_state = S12;
			S12: next_state = (divpix_delay < 4'd15) ? S12 : DONE;
			DONE: next_state = WAIT_GEN;
			default: next_state = WAIT_GEN;
		endcase
	end
			
	always @(posedge clk) begin
		case (state)
			WAIT_GEN: begin
				wr11 <= 7'd0;
				wr12 <= 7'd0;
				wr13 <= 7'd0;
				wr21 <= 7'd0;
				wr22 <= 7'd64;
				wr23 <= 7'd0;
				wr31 <= 7'd0;
				wr32 <= 7'd0;
				wr33 <= 7'd0;
				ws11 <= 7'd1;
				ws12 <= 7'd8;
				ws13 <= 7'd1;
				ws21 <= 7'd8;
				ws22 <= 7'd64;
				ws23 <= 7'd8;
				ws31 <= 7'd1;
				ws32 <= 7'd8;
				ws33 <= 7'd1;
				a11 <= p1;
				a12 <= p2;
				a13 <= p3;
				a21 <= p4;
				a22 <= p5;
				a23 <= p6;
				a31 <= p7;
				a32 <= p8;
				a33 <= p9;
				delay_coeff <= 2'd0;
				div_delay <= 2'd0;
				delay_pix <= 2'd0;
				divpix_delay <= 4'd0;
				delay <= 1'b0;
			end
			S1: begin
				diff_11 <= (a22 > a11) ? (a22 - a11) : (a11 - a22);
				diff_12 <= (a22 > a12) ? (a22 - a11) : (a12 - a22);
				diff_13 <= (a22 > a13) ? (a22 - a11) : (a13 - a22);
				diff_21 <= (a22 > a21) ? (a22 - a11) : (a21 - a22);
				diff_22 <= 8'd0;
				diff_23 <= (a22 > a23) ? (a22 - a11) : (a23 - a22);
				diff_31 <= (a22 > a31) ? (a22 - a11) : (a31 - a22);
				diff_32 <= (a22 > a32) ? (a22 - a11) : (a32 - a22);
				diff_33 <= (a22 > a33) ? (a22 - a11) : (a33 - a22);
				delay <= delay + 1'b1;
			end
			S2: begin
				div_delay <= div_delay + 1'b1;
			end
			S3: begin
				div_delay <= 2'd0;
				d11_reg <= d11_div;
				d12_reg <= d12_div;
				d13_reg <= d13_div;
				d21_reg <= d21_div;
				d22_reg <= 8'd0;
				d23_reg <= d23_div;
				d31_reg <= d31_div;
				d32_reg <= d32_div;
				d33_reg <= d33_div;
			end
			S4: begin
				if (d11_reg < 8'd16) 
					wr11 <= 7'd64;
				else if (d11_reg < 8'd27)
					wr11 <= 7'd60;
				else if (d11_reg < 8'd39)
					wr11 <= 7'd56;
				else if (d11_reg < 8'd52)
					wr11 <= 7'd48;
				else if (d11_reg < 8'd65)
					wr11 <= 7'd40;
				else if (d11_reg < 8'd78)
					wr11 <= 7'd32;
				else if (d11_reg < 8'd88)
					wr11 <= 7'd24;
				else if (d11_reg < 8'd96)
					wr11 <= 7'd20;
				else if (d11_reg < 8'd105)
					wr11 <= 7'd16;
				else if (d11_reg < 8'd116)
					wr11 <= 7'd12;
				else if (d11_reg < 8'd131)
					wr11 <= 7'd8;
				else if (d11_reg < 8'd149)
					wr11 <= 7'd4;
				else if (d11_reg < 8'd158)
					wr11 <= 7'd2;
				else if (d11_reg < 8'd174)
					wr11 <= 7'd1;
				else 
					wr11 <= 7'd0;

				if (d12_reg < 8'd16) 
					wr12 <= 7'd64;
				else if (d12_reg < 8'd27)
					wr12 <= 7'd60;
				else if (d12_reg < 8'd39)
					wr12 <= 7'd56;
				else if (d12_reg < 8'd52)
					wr12 <= 7'd48;
				else if (d12_reg < 8'd65)
					wr12 <= 7'd40;
				else if (d12_reg < 8'd78)
					wr12 <= 7'd32;
				else if (d12_reg < 8'd88)
					wr12 <= 7'd24;
				else if (d12_reg < 8'd96)
					wr12 <= 7'd20;
				else if (d12_reg < 8'd105)
					wr12 <= 7'd16;
				else if (d12_reg < 8'd116)
					wr12 <= 7'd12;
				else if (d12_reg < 8'd131)
					wr12 <= 7'd8;
				else if (d12_reg < 8'd149)
					wr12 <= 7'd4;
				else if (d12_reg < 8'd158)
					wr12 <= 7'd2;
				else if (d12_reg < 8'd174)
					wr12 <= 7'd1;
				else
					wr12 <= 7'd0;

				if (d13_reg < 8'd16) 
					wr13 <= 7'd64;
				else if (d13_reg < 8'd27)
					wr13 <= 7'd60;
				else if (d13_reg < 8'd39)
					wr13 <= 7'd56;
				else if (d13_reg < 8'd52)
					wr13 <= 7'd48;
				else if (d13_reg < 8'd65)
					wr13 <= 7'd40;
				else if (d13_reg < 8'd78)
					wr13 <= 7'd32;
				else if (d13_reg < 8'd88)
					wr13 <= 7'd24;
				else if (d13_reg < 8'd96)
					wr13 <= 7'd20;
				else if (d13_reg < 8'd105)
					wr13 <= 7'd16;
				else if (d13_reg < 8'd116)
					wr13 <= 7'd12;
				else if (d13_reg < 8'd131)
					wr13 <= 7'd8;
				else if (d13_reg < 8'd149)
					wr13 <= 7'd4;
				else if (d13_reg < 8'd158)
					wr13 <= 7'd2;
				else if (d13_reg < 8'd174)
					wr13 <= 7'd1;
				else 
					wr13 <= 7'd0;

				if (d21_reg < 8'd16) 
					wr21 <= 7'd64;
				else if (d21_reg < 8'd27)
					wr21 <= 7'd60;
				else if (d21_reg < 8'd39)
					wr21 <= 7'd56;
				else if (d21_reg < 8'd52)
					wr21 <= 7'd48;
				else if (d21_reg < 8'd65)
					wr21 <= 7'd40;
				else if (d21_reg < 8'd78)
					wr21 <= 7'd32;
				else if (d21_reg < 8'd88)
					wr21 <= 7'd24;
				else if (d21_reg < 8'd96)
					wr21 <= 7'd20;
				else if (d21_reg < 8'd105)
					wr21 <= 7'd16;
				else if (d21_reg < 8'd116)
					wr21 <= 7'd12;
				else if (d21_reg < 8'd131)
					wr21 <= 7'd8;
				else if (d21_reg < 8'd149)
					wr21 <= 7'd4;
				else if (d21_reg < 8'd158)
					wr21 <= 7'd2;
				else if (d21_reg < 8'd174)
					wr21 <= 7'd1;
				else 
					wr21 <= 7'd0;

				if (d23_reg < 8'd16) 
					wr23 <= 7'd64;
				else if (d23_reg < 8'd27)
					wr23 <= 7'd60;
				else if (d23_reg < 8'd39)
					wr23 <= 7'd56;
				else if (d23_reg < 8'd52)
					wr23 <= 7'd48;
				else if (d23_reg < 8'd65)
					wr23 <= 7'd40;
				else if (d23_reg < 8'd78)
					wr23 <= 7'd32;
				else if (d23_reg < 8'd88)
					wr23 <= 7'd24;
				else if (d23_reg < 8'd96)
					wr23 <= 7'd20;
				else if (d23_reg < 8'd105)
					wr23 <= 7'd16;
				else if (d23_reg < 8'd116)
					wr23 <= 7'd12;
				else if (d23_reg < 8'd131)
					wr23 <= 7'd8;
				else if (d23_reg < 8'd149)
					wr23 <= 7'd4;
				else if (d23_reg < 8'd158)
					wr23 <= 7'd2;
				else if (d23_reg < 8'd174)
					wr23 <= 7'd1;
				else 
					wr23 <= 7'd0;

				if (d31_reg < 8'd16) 
					wr31 <= 7'd64;
				else if (d31_reg < 8'd27)
					wr31 <= 7'd60;
				else if (d31_reg < 8'd39)
					wr31 <= 7'd56;
				else if (d31_reg < 8'd52)
					wr31 <= 7'd48;
				else if (d31_reg < 8'd65)
					wr31 <= 7'd40;
				else if (d31_reg < 8'd78)
					wr31 <= 7'd32;
				else if (d31_reg < 8'd88)
					wr31 <= 7'd24;
				else if (d31_reg < 8'd96)
					wr31 <= 7'd20;
				else if (d31_reg < 8'd105)
					wr31 <= 7'd16;
				else if (d31_reg < 8'd116)
					wr31 <= 7'd12;
				else if (d31_reg < 8'd131)
					wr31 <= 7'd8;
				else if (d31_reg < 8'd149)
					wr31 <= 7'd4;
				else if (d31_reg < 8'd158)
					wr31 <= 7'd2;
				else if (d31_reg < 8'd174)
					wr31 <= 7'd1;
				else 
					wr31 <= 7'd0;

				if (d32_reg < 8'd16) 
					wr32 <= 7'd64;
				else if (d32_reg < 8'd27)
					wr32 <= 7'd60;
				else if (d32_reg < 8'd39)
					wr32 <= 7'd56;
				else if (d32_reg < 8'd52)
					wr32 <= 7'd48;
				else if (d32_reg < 8'd65)
					wr32 <= 7'd40;
				else if (d32_reg < 8'd78)
					wr32 <= 7'd32;
				else if (d32_reg < 8'd88)
					wr32 <= 7'd24;
				else if (d32_reg < 8'd96)
					wr32 <= 7'd20;
				else if (d32_reg < 8'd105)
					wr32 <= 7'd16;
				else if (d32_reg < 8'd116)
					wr32 <= 7'd12;
				else if (d32_reg < 8'd131)
					wr32 <= 7'd8;
				else if (d32_reg < 8'd149)
					wr32 <= 7'd4;
				else if (d32_reg < 8'd158)
					wr32 <= 7'd2;
				else if (d32_reg < 8'd174)
					wr32 <= 7'd1;
				else 
					wr32 <= 7'd0;

				if (d33_reg < 8'd16) 
					wr33 <= 7'd64;
				else if (d33_reg < 8'd27)
					wr33 <= 7'd60;
				else if (d33_reg < 8'd39)
					wr33 <= 7'd56;
				else if (d33_reg < 8'd52)
					wr33 <= 7'd48;
				else if (d33_reg < 8'd65)
					wr33 <= 7'd40;
				else if (d33_reg < 8'd78)
					wr33 <= 7'd32;
				else if (d33_reg < 8'd88)
					wr33 <= 7'd24;
				else if (d33_reg < 8'd96)
					wr33 <= 7'd20;
				else if (d33_reg < 8'd105)
					wr33 <= 7'd16;
				else if (d33_reg < 8'd116)
					wr33 <= 7'd12;
				else if (d33_reg < 8'd131)
					wr33 <= 7'd8;
				else if (d33_reg < 8'd149)
					wr33 <= 7'd4;
				else if (d33_reg < 8'd158)
					wr33 <= 7'd2;
				else if (d33_reg < 8'd174)
					wr33 <= 7'd1;
				else 
					wr33 <= 7'd0;
			end
			S5: begin
				delay_coeff <= delay_coeff + 1'b1;
			end
			S6: begin
				c11_reg <= coeff_11;
				c12_reg <= coeff_12;
				c13_reg <= coeff_13;
				c21_reg <= coeff_21;
				c22_reg <= coeff_22;
				c23_reg <= coeff_23;
				c31_reg <= coeff_31;
				c32_reg <= coeff_32;
				c33_reg <= coeff_33;
			end
			S7: begin
				delay_pix <= delay_pix + 1'b1;
			end
			S8: begin
				cpp11_reg <= cpp_11;
				cpp12_reg <= cpp_12;
				cpp13_reg <= cpp_13;
				cpp21_reg <= cpp_21;
				cpp22_reg <= cpp_22;
				cpp23_reg <= cpp_23;
				cpp31_reg <= cpp_31;
				cpp32_reg <= cpp_32;
				cpp33_reg <= cpp_33;
			end
			S9: begin
				cpp1_sum <= cpp11_reg + cpp12_reg;
				cpp2_sum <= cpp13_reg + cpp21_reg;
				cpp3_sum <= cpp22_reg + cpp23_reg;
				cpp4_sum <= cpp31_reg + cpp32_reg;
				c1_sum <= c11_reg + c12_reg;
				c2_sum <= c13_reg + c21_reg;
				c3_sum <= c22_reg + c23_reg;
				c4_sum <= c31_reg + c32_reg;
			end
			S10: begin
				cpp5_sum <= cpp1_sum + cpp2_sum;
				cpp6_sum <= cpp3_sum + cpp4_sum;
				c5_sum <= c1_sum + c2_sum;
				c6_sum <= c3_sum + c4_sum;
			end
			S11: begin
				coeff_sum <= c5_sum + c6_sum + c33_reg;
				coepix_sum <= cpp5_sum + cpp6_sum + cpp33_reg;
			end
			S12: begin
				divpix_delay <= divpix_delay + 1'b1;
			end
			DONE: begin
			end
			default: begin
				divpix_delay <= 4'd0;
				delay_pix <= 2'd0;
				div_delay <= 2'd0;
				delay_coeff <= 2'd0;
			end
		endcase
	end

	always @(posedge clk) begin
		if (rst) begin
			state <= WAIT_GEN;
			new_pix <= 8'd0;
		end
		else begin
			new_pix <= new_pix_v;
			state <= next_state;
		end
	end
	
	assign en_div = (state == S2) ? 1'b1 : 1'b0;
	assign en_mult_coeff = (state == S5) ? 1'b1 : 1'b0;
	assign en_mult_pix = (state == S7) ? 1'b1 : 1'b0;
	assign en_div_pix = (state == S12) ? 1'b1 : 1'b0;
	assign done_filt = (state == DONE) ? (1'b1) : (1'b0);
endmodule

