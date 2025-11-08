`timescale 10ms/1ns
`include "button.v"
`include "lock.v"
`include "lock_call.v"
`include "intercom.v"
`include "DoorLock.v"

module DoorLock_tb;
   reg clk, reset_in, sel_in;
   reg b_call_in, unit_connect_in, unit_accept_in, unit_defuse_in;
   reg Enter_in, reject_in, delete_in;
   reg b0_in, b1_in, b2_in, b3_in, b4_in, b5_in, b6_in, b7_in, b8_in, b9_in, b_ast_in, b_pound_in;
   reg A_in, B_in, C_in, D_in, E_in, F_in, G_in, H_in, I_in, J_in, K_in, L_in, M_in, N_in, O_in, P_in, Q_in, R_in, S_in, T_in, U_in, V_in, W_in, X_in, Y_in, Z_in;
   wire	unlock;

   
   DoorLock i0 (/*AUTOINST*/
		// Outputs
		.unlock			(unlock),
		// Inputs
		.sel_in			(sel_in),
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
		.b_ast_in		(b_ast_in),
		.b_pound_in		(b_pound_in),
		.b_call_in		(b_call_in),
		.unit_connect_in	(unit_connect_in),
		.unit_accept_in		(unit_accept_in),
		.unit_defuse_in		(unit_defuse_in),
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
		.delete_in		(delete_in));

   always
     #10 clk <= ~clk;

   initial begin
      $dumpfile("DoorLock_tb.vcd");
      $dumpvars(0, DoorLock_tb);

      //initialization
      clk=0; reset_in=0; sel_in=0;
      b_call_in=0; unit_connect_in=0; unit_accept_in=0; unit_defuse_in=0;
      Enter_in=0; reject_in=0;
      b0_in=0; b1_in=0; b2_in=0; b3_in=0; b4_in=0; b5_in=0; b6_in=0; b7_in=0; b8_in=0; b9_in=0; b_ast_in=0; b_pound_in=0;
      A_in=0; B_in=0; C_in=0; D_in=0; E_in=0; F_in=0; G_in=0; H_in=0; I_in=0; J_in=0; K_in=0; L_in=0; M_in=0; N_in=0; O_in=0; P_in=0; Q_in=0; R_in=0; S_in=0; T_in=0; U_in=0; V_in=0; W_in=0; X_in=0; Y_in=0; Z_in=0;

      //첫번째 사람, 도어락
      #20 reset_in=1; #60 reset_in=0; //reset
      #40 sel_in=1; #40 sel_in=0; //select
      #80 b0_in=1; #40 b0_in=0; //0
      #40 b1_in=1; #40 b1_in=0; //1
      #40 b0_in=1; #40 b0_in=0; //0
      #40 b1_in=1; #40 b1_in=0; //1
      #40 b1_in=1; #40 b1_in=0; //1
      #40 b0_in=1; #40 b0_in=0; //change mode
      #40 b5_in=1; #40 b5_in=0; //5
      #40 b8_in=1; reject_in=1; #40 b8_in=0; reject_in=0; //8
      #40 b3_in=1; #40 b3_in=0; //3
      #40 b4_in=1; #40 b4_in=0; //4
      #40 b7_in=1; #40 b7_in=0; //7, change
      #40 b1_in=1; #40 b1_in=0; //1
      #40 b5_in=1; #40 b5_in=0; //5
      #40 b8_in=1; #40 b8_in=0; //8
      #40 b3_in=1; #40 b3_in=0; //3
      #40 b4_in=1; #40 b4_in=0; //4
      #40 b7_in=1; #40 b7_in=0; //7, correct
      #40 b1_in=1; #40 b1_in=0;
      //경비실
      #160 H_in=1; #40 H_in=0;
      #40 O_in=1; #40 O_in=0;
      #40 N_in=1; #40 N_in=0;
      #40 G_in=1; #40 G_in=0;
      #40 S_in=1; #40 S_in=0;
      #40 A_in=1; #40 A_in=0;
      #40 N_in=1; #40 N_in=0;
      #40 G_in=1; #40 G_in=0;
      #40 H_in=1; #40 H_in=0;
      #40 O_in=1; #40 O_in=0;
      #40 O_in=1; #40 O_in=0;
      #40 N_in=1; #40 N_in=0;     
      #40 Enter_in=1; #40 Enter_in=0; //문열림

      //두 번째 사람, 도어락
      #500 b_call_in=1; #40 b_call_in=0;
      #40 b_call_in=1; #40 b_call_in=0;
      //경비실
      #160 reject_in=1; #40 reject_in=0; //거절당함, 문이 열리지 않음
      //도어락
      #80 b_call_in=1; #40 b_call_in=0;
      #40 b1_in=1; #40 b1_in=0;
      #40 b2_in=1; #40 b2_in=0;
      #40 b0_in=1; #40 b0_in=0;
      #40 b5_in=1; #40 b5_in=0;
      #40 b_call_in=1; #40 b_call_in=0;
      //세대
      #80 unit_connect_in=1; #40 unit_connect_in=0;
      #160 unit_accept_in=1; #40 unit_accept_in=0;
      //경비실
      #240 L_in=1; #40 L_in=0;
      #40 E_in=1; #40 E_in=0;
      #40 E_in=1; #40 E_in=0;
      #40 M_in=1; #40 M_in=0;
      #40 I_in=1; #40 I_in=0;
      #40 N_in=1; #40 N_in=0;
      #40 H_in=1; #40 H_in=0;
      #40 E_in=1; #40 E_in=0;
      #40 E_in=1; #40 E_in=0;     
      #40 Enter_in=1; #40 Enter_in=0; //문열림   
      #400 $finish;
      
   end // initial begin
   
endmodule // DoorLock_tb
