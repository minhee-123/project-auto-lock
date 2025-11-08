module DoorLock (
		 input	sel_in,
		 input	clk,
		 input	reset_in,
		 input	b0_in,
		 input	b1_in,
		 input	b2_in,
		 input	b3_in,
		 input	b4_in,
		 input	b5_in,
		 input	b6_in,
		 input	b7_in,
		 input	b8_in,
		 input	b9_in,
		 input	b_ast_in,
		 input	b_pound_in, 
		 input	b_call_in, 
		 input	unit_connect_in,
		 input	unit_accept_in,
		 input	unit_defuse_in, 
		 input	A_in,
		 input	B_in,
		 input	C_in,
		 input	D_in,
		 input	E_in,
		 input	F_in,
		 input	G_in,
		 input	H_in,
		 input	I_in,
		 input	J_in,
		 input	K_in,
		 input	L_in,
		 input	M_in,
		 input	N_in,
		 input	O_in,
		 input	P_in,
		 input	Q_in,
		 input	R_in,
		 input	S_in,
		 input	T_in,
		 input	U_in,
		 input	V_in,
		 input	W_in,
		 input	X_in,
		 input	Y_in,
		 input	Z_in,
		 input	Enter_in, 
		 input	reject_in,
		 input	delete_in,

		 output	unlock
		 /*AUTOARG*/);
   wire			out1;
   wire			out2;
   wire [2:0]		hex_display;
   wire [7:0]		ASCII_display;

   reg			input_signal;

   always @(*) begin
      input_signal = out1 | out2;
   end
   
   //비밀번호 입력 및 재설정
   lock i1 (/*AUTOINST*/
	    // Outputs
	    .out			(out1),
	    .hex_display		(hex_display[2:0]),
	    // Inputs
	    .clk			(clk),
	    .sel_in			(sel_in),
	    .b0_in			(b0_in),
	    .b1_in			(b1_in),
	    .b2_in			(b2_in),
	    .b3_in			(b3_in),
	    .b4_in			(b4_in),
	    .b5_in			(b5_in),
	    .b6_in			(b6_in),
	    .b7_in			(b7_in),
	    .b8_in			(b8_in),
	    .b9_in			(b9_in),
	    .b_ast_in			(b_ast_in),
	    .b_pound_in			(b_pound_in));

   //경비원 호출 및 세대 호출
   lock_call i2 (/*AUTOINST*/
		 // Outputs
		 .out			(out2),
		 // Inputs
		 .clk			(clk),
		 .reset_in		(reset_in),
		 .b0_in			(b0_in),
		 .b1_in			(b1_in),
		 .b2_in			(b2_in),
		 .b3_in			(b3_in),
		 .b4_in			(b4_in),
		 .b5_in			(b5_in),
		 .b6_in			(b6_in),
		 .b7_in			(b7_in),
		 .b8_in			(b8_in),
		 .b9_in			(b9_in),
		 .b_call_in		(b_call_in),
		 .unit_connect_in	(unit_connect_in),
		 .unit_accept_in	(unit_accept_in),
		 .unit_defuse_in	(unit_defuse_in));

   //경비원의 이름 입력 및 문열림 모드
   intercom i3 (/*AUTOINST*/
		// Outputs
		.output_signal		(unlock),
		.ASCII_display		(ASCII_display[7:0]),
		// Inputs
		.input_signal		(input_signal),
		.clk			(clk),
		.A_in			(A_in),
		.B_in			(B_in),
		.C_in			(C_in),
		.D_in			(D_in),
		.E_in			(E_in),
		.F_in			(F_in),
		.G_in			(G_in),
		.H_in			(H_in),
		.I_in			(I_in),
		.J_in			(J_in),
		.K_in			(K_in),
		.L_in			(L_in),
		.M_in			(M_in),
		.N_in			(N_in),
		.O_in			(O_in),
		.P_in			(P_in),
		.Q_in			(Q_in),
		.R_in			(R_in),
		.S_in			(S_in),
		.T_in			(T_in),
		.U_in			(U_in),
		.V_in			(V_in),
		.W_in			(W_in),
		.X_in			(X_in),
		.Y_in			(Y_in),
		.Z_in			(Z_in),
		.Enter_in		(Enter_in),
		.reject_in		(reject_in),
		.reset_in		(reset_in),
		.delete_in	        (delete_in));
   
endmodule // DoorLock   
