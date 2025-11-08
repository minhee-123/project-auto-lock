module lock_call (unit_connect,unit_defuse, unit_accept,clk, rst, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b_call, out);

   input clk, rst, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b_call; // 앞에b가 있는 것은 버튼으로 입력 받음
   input unit_connect, unit_accept, unit_defuse; // 세대 연결 및 세대 수락 및 거절
   output reg out;

   reg [15:0] unit_num; //세대 호수
   
   reg	      call_security; //경비원 호출
   reg	      call_unit; // 세대 호출
   reg [1:0]  call_count; // call 누른 횟수
   reg	      unit_call; //세대와 연결됨
   reg	      unit_accept_var; // 수락
   reg	      unit_defuse_var; // 거절

   reg [10:0] count_1, count_2, count_3;// 딜레이를 주기 위한 count
   


   always @(posedge clk) begin
      if (rst) begin

	 call_count<=0;
	 unit_num<=0;
	 out <=0;
	 call_security <=0;
	 call_unit <=0;
	 
	 count_1 <=0;
	 count_2 <=0;
	 count_3 <=0;
	 
	 unit_call <=0;
	 unit_accept_var <=0;
	 unit_defuse_var <=0;
	 
      end
      if (call_security==1)//경비실 연락시 시작
	count_1 <= count_1 +1;
      if (call_unit==1)//세대 연락시 시작
	count_2 <= count_2 +1;
      if (unit_accept_var)
	count_3 <= count_3 +1;
   end // always @ (posedge clk)



   
   always @(posedge unit_connect) begin
      if (call_unit==1) // 세대 호출 상태일 때
	unit_call <= 1;
   end

   always @(posedge unit_accept) begin
      if( unit_call==1)//세대와 통화 중일 때만 반응
	unit_accept_var <= 1;
   end

   always @(posedge unit_defuse) begin
      if( unit_call==1)//세대와 통화 중일 때만 반응
	unit_defuse_var <= 1;
   end

   
   always @(posedge b_call) begin // 입력 받은것을 토대로 경비실 또는 세대 호출
      call_count = call_count +1;
      if (call_count==2)begin
	 call_count <= 0;
	 if (unit_num ==0) begin
	    call_security <=1;
	 end
	 else begin
	    call_unit <=1;
	 end
	 // 아무 세대 호출을 해도 됨
      end
   end

   
   always @ (posedge b0 or posedge b1 or posedge b2 or posedge b3 or posedge b4 or posedge b5 or posedge b6 or posedge b7 or posedge b8 or posedge b9) begin
      if ((call_count==1) && (unit_num[15:12] == 4'b0000)) begin
	 if (b0)
	   unit_num <= unit_num*16;
	 else if (b1)
	   unit_num <= unit_num*16+1;
	 else if (b2)
	   unit_num <= unit_num*16+2;
	 else if (b3)
	   unit_num <= unit_num*16+3;
	 else if (b4)
	   unit_num <= unit_num*16+4;
	 else if (b5)
	   unit_num <= unit_num*16+5;
	 else if (b6)
	   unit_num <= unit_num*16+6;
	 else if (b7)
	   unit_num <= unit_num*16+7;
	 else if (b8)
	   unit_num <= unit_num*16+8;
	 else if (b9)
	   unit_num <= unit_num*16+9;
      end
   end 
   
   always @ (*) begin
      if(call_security==1)begin//바로 경비실 호출
	 out <= 1;
	 if (count_1>2) begin
	    out <= 0;
	    count_1 <= 0;
	    call_security <=0;
	 end
      end
      
      if (call_unit==1)begin//세대 통화 시도
	 if ((count_2 <12) && (unit_call==1)) begin //통화 수락
	    count_2 <=1; // 현재 상태를 유지 시키기 위함
	    if(unit_accept_var==1)begin//허락시 경비실 연락
	       out=1;// 경비실 연락후 초기화
	       if (count_3>1) begin
		  out <= 0;
		  count_2 <= 0;
		  count_3 <= 0;
		  call_unit <=0;
		  unit_accept_var <=0;
		  unit_call <=0;
		  unit_num <=0;
	       end  
	    end
	    
	    else if (unit_defuse_var==1)begin //통화 거절 초기화
	       count_1 <=0;
	       count_2 <=0;
	       call_unit <=0;
	       unit_defuse_var <=0;
	       unit_num <=0;
	       unit_call <=0;
	    end
	 end
	 else if(count_2 >12)begin//세대와의 연락이없음 (경비실 연락)
	    out <= 1;// 경비실 연락후 초기화
	    if (count_2>13) begin
	       out <= 0;
	       count_2 <= 0;
	       call_unit <=0;
	       unit_num <=0;
	       unit_call <=0;
	    end
	 end
      end // if (call_unit==1)
   end // always @ (*)
   
endmodule // lock_call

