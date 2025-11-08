module intercom(clk,rst_in,A_in,B_in,C_in,D_in,E_in,F_in,G_in,H_in,I_in,J_in,K_in,L_in,M_in,N_in,O_in,P_in,Q_in,R_in,S_in,T_in,U_in,V_in,W_in,X_in,Y_in,Z_in,Enter_in,reject_in,delete_in,input_signal,output_signal,ASCII_display);

   input clk; //clk,rst
   input A_in,B_in,C_in,D_in,E_in,F_in,G_in,H_in,I_in,
	 J_in,K_in,L_in,M_in,N_in,O_in,P_in,Q_in,R_in,S_in,
	 T_in,	U_in,V_in,W_in,X_in,Y_in,Z_in,Enter_in,reject_in,rst_in,delete_in; //버튼
   input input_signal;
   ////////////////////////////////////////////////////////////////////////
   output reg output_signal=0;
   output [7:0]	ASCII_display;

   wire		A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z;
   
   /////////////////////////////////state parameter///////////////////////////////////
   parameter	active=1;
   parameter	inactive=0;
   /////////////////////////////////////////////////////////////////////////////////

   integer	j=0;
   integer	i;
   //////////////////////////////////////register///////////////////////////////////   
   reg [7:0]	count=0;
   reg		match=0;
   reg [7:0]	alpha=0;
   reg [7:0]	name_list [0:255]; // array to store the words
   reg [7:0]	name [0:31]; // array to store the current input word
   reg		state=0;
   reg		[1:0]counter=3'b000;

   
   assign ASCII_display=alpha;


   
   /////////////////////////////////////////////////////////////////////////////
   button b_rst(.clk(clk),.in(rst_in),.out(rst));
   button b_A(.clk(clk),.in(A_in),.out(A));
   button b_B(.clk(clk),.in(B_in),.out(B));
   button b_C(.clk(clk),.in(C_in),.out(C));
   button b_D(.clk(clk),.in(D_in),.out(D));
   button b_E(.clk(clk),.in(E_in),.out(E));
   button b_F(.clk(clk),.in(F_in),.out(F));
   button b_G(.clk(clk),.in(G_in),.out(G));
   button b_H(.clk(clk),.in(H_in),.out(H));
   button b_I(.clk(clk),.in(I_in),.out(I));
   button b_J(.clk(clk),.in(J_in),.out(J));
   button b_K(.clk(clk),.in(K_in),.out(K));
   button b_L(.clk(clk),.in(L_in),.out(L));
   button b_M(.clk(clk),.in(M_in),.out(M));
   button b_N(.clk(clk),.in(N_in),.out(N));
   button b_O(.clk(clk),.in(O_in),.out(O));
   button b_P(.clk(clk),.in(P_in),.out(P));
   button b_Q(.clk(clk),.in(Q_in),.out(Q));
   button b_R(.clk(clk),.in(R_in),.out(R));
   button b_S(.clk(clk),.in(S_in),.out(S));
   button b_T(.clk(clk),.in(T_in),.out(T));
   button b_U(.clk(clk),.in(U_in),.out(U));
   button b_V(.clk(clk),.in(V_in),.out(V));
   button b_W(.clk(clk),.in(W_in),.out(W));
   button b_X(.clk(clk),.in(X_in),.out(X));
   button b_Y(.clk(clk),.in(Y_in),.out(Y));
   button b_Z(.clk(clk),.in(Z_in),.out(Z));
   button b_reject(.clk(clk),.in(reject_in),.out(reject));
   button b_delete(.clk(clk),.in(delete_in),.out(delete));
   button b_Enter(.clk(clk),.in(Enter_in),.out(Enter));
   /////////////////////////////////////////////////////////////////////////

   initial begin
      $readmemh("name_list.txt", name_list);
      for (i = 0; i < 32; i = i + 1) begin
	 name[i] <= 8'h00;
      end
   end

   
   always @ (posedge clk)begin
      if(input_signal)begin
	 state<=1;
      end
      else if (output_signal)begin
	 if (counter==2'b10)begin
	 match<=0;
	 state<=0;end
	 else begin
	   counter<=counter +2'b01;
	 end
      end
   end // always @ (posedge clk)
   
   
   always@(posedge clk)begin
      if(rst)
	begin
	   alpha <= 8'h00;
	   for (i = 0; i < 32; i = i + 1) begin
	      name[i] <= 8'h00;
	   end
	   count <= 0;
	   match <= 0;
	   alpha<=0;
	end
      else case(state)
	     inactive:begin
		for (i = 0; i < 32; i = i + 1) begin
		   name[i] <= 8'h00;
		end
		match<=0;
		count<=0;
		alpha<=0;
		output_signal<=0;
	     end
	     active :begin
		if (A) begin
		   alpha <= "A";
		   name[count] <= "A";
		   count <= count + 1;
		end
		else if (B) begin
		   alpha <= "B";
		   name[count] <= "B";
		   count <= count + 1;
		end
		else if (C) begin
		   alpha <= "C";
		   name[count] <= "C";
		   count <= count + 1;
		end
		else if (D) begin
		   alpha <= "D";
		   name[count] <= "D";
		   count <= count + 1;
		end
		else if (E) begin
		   alpha <= "E";
		   name[count] <= "E";
		   count <= count + 1;
		end
		else if (F) begin
		   alpha <= "F";
		   name[count] <= "F";
		   count <= count + 1;
		end
		else if (G) begin
		   alpha <= "G";
		   name[count] <= "G";
		   count <= count + 1;
		end
		else if (H) begin
		   alpha <= "H";
		   name[count] <= "H";
		   count <= count + 1;
		end
		else if (I) begin
		   alpha <= "I";
		   name[count] <= "I";
		   count <= count + 1;
		end
		else if (J) begin
		   alpha <= "J";
		   name[count] <= "J";
		   count <= count + 1;
		end
		else if (K) begin
		   alpha <= "K";
		   name[count] <= "K";
		   count <= count + 1;
		end
		else if (L) begin
		   alpha <= "L";
		   name[count] <= "L";
		   count <= count + 1;
		end
		else if (M) begin
		   alpha <= "M";
		   name[count] <= "M";
		   count <= count + 1;
		end
		else if (N) begin
		   alpha <= "N";
		   name[count] <= "N";
		   count <= count + 1;
		end
		else if (O) begin
		   alpha <= "O";
		   name[count] <= "O";
		   count <= count + 1;
		end
		else if (P) begin
		   alpha<="P";
		   name[count]<="P";
		   count<= count+1;
		end 
		else if (Q) begin
		   alpha <= "Q";
		   name[count] <= "Q";
		   count <= count + 1;
		end
		else if (R) begin
		   alpha <= "R";
		   name[count] <= "R";
		   count <= count + 1;
		end
		else if (S) begin
		   alpha <= "S";
		   name[count] <= "S";
		   count <= count + 1;
		end
		else if (T) begin
		   alpha <= "T";
		   name[count] <= "T";
		   count <= count + 1;
		end
		else if (U) begin
		   alpha <= "U";
		   name[count] <= "U";
		   count <= count + 1;
		end
		else if (V) begin
		   alpha<="V";
		   name[count]<="V";
		   count<= count+1; 
		end
		else if (W) begin
		   alpha <= "W";
		   name[count] <= "W";
		   count <= count + 1;
		end
		else if (X) begin
		   alpha <= "X";
		   name[count] <= "X";
		   count <= count + 1;
		end
		else if (Y) begin
		   alpha <= "Y";
		   name[count] <= "Y";
		   count <= count + 1;
		end
		else if (Z) begin
		   alpha <= "Z";
		   name[count] <= "Z";
		   count <= count + 1;
		end
		else if (reject) begin
		   state<=0;
		end
		else if (delete) begin
		   name[count-1]<=0;
		   count<=count-1;
		   alpha<="-";
		end
				
		else if (Enter) begin
		   for(i = 0; i < 256; i = i + 1) begin
		      if(name_list[i] == name[j]) begin
			 j = j + 1;
		      end
		      else if(j !=0 && name[j]== 0 && name_list[i]==8'h2C)begin
			 match<=1;
		      end
		      else begin
			 j=0;
		      end   
		   end // for (i = 0; i < N; i = i + 1)
		   for (j= 0; i < 32; j = j + 1) begin
		      name[i] <= 8'h00;
		   end
		   count=0;
		end // if (Enter)
	     end // case: begin...
	   endcase // case (state)
      if (match)begin
	 output_signal<=1;
      end
      
   end // always@ (posedge clk)
endmodule // intercom
