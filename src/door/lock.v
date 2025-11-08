module lock(
    input clk,
    input sel_in,
    input b0_in,
    input b1_in,
    input b2_in,
    input b3_in,
    input b4_in,
    input b5_in,
    input b6_in,
    input b7_in,
    input b8_in,
    input b9_in,
    input b_ast_in,
    input b_pound_in,

    output out,
    output [2:0] hex_display
);

wire sel, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b_ast, b_pound;
button b_sel(.clk(clk), .in(sel_in), .out(sel));
button b_0(.clk(clk), .in(b0_in), .out(b0));
button b_1(.clk(clk), .in(b1_in), .out(b1));
button b_2(.clk(clk), .in(b2_in), .out(b2));
button b_3(.clk(clk), .in(b3_in), .out(b3));
button b_4(.clk(clk), .in(b4_in), .out(b4));
button b_5(.clk(clk), .in(b5_in), .out(b5));
button b_6(.clk(clk), .in(b6_in), .out(b6));
button b_7(.clk(clk), .in(b7_in), .out(b7));
button b_8(.clk(clk), .in(b8_in), .out(b8));
button b_9(.clk(clk), .in(b9_in), .out(b9));
button b_asterisk(.clk(clk), .in(b_ast_in), .out(b_ast));
button b_pound0(.clk(clk), .in(b_pound_in), .out(b_pound));


parameter S_RESET = 0;
parameter S_0 = 1;
parameter S_01 = 2;
parameter S_010 = 3;
parameter S_0101 = 4;
parameter S_01011 = 5;
parameter S_CHANGE_PASSWORD = 6;

reg [2:0] state;
reg [19:0] password;
reg [2:0] counter;
reg [3:0] error_counter;
reg [3:0] number;

initial begin
    password = 20'b0000_0001_0000_0001_0001;
    counter = 3'b000;
    error_counter = 4'b0000;
end

always @((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9|b_ast|b_pound)) begin
    number <= (b0) ? 4'b0000 : (b1) ? 4'b0001 : (b2) ? 4'b0010 : (b3) ? 4'b0011 : (b4) ? 4'b0100 : (b5) ? 4'b0101 : (b6) ? 4'b0110 : (b7) ? 4'b0111 : (b8) ? 4'b1000 : (b9) ? 4'b1001 : (b_ast) ? 4'b1010 : (b_pound) ? 4'b1011 : 1'bx;
end

always @(posedge clk, posedge sel) begin
    if(error_counter<4'b0101) begin    
        if (sel) begin
            state <= S_RESET;
        end 
        else if(b0|b1|b2|b3|b4|b5|b6|b7|b8|b9|b_ast|b_pound) begin
            case (state)
                S_RESET: begin
                    if (password[19:16]==number) begin
                        state <= S_0;
                    end 
                    else if (password[19:16]!==number) begin
                        state <= S_RESET;
                        error_counter <= error_counter + 1;
                    end
                    else begin
                        state <= state;
                    end
                end
                S_0: begin
                    if (password[15:12]==number) begin
                        state <= S_01;
                    end 
                    else if (password[15:12]!==number) begin
                        state <= S_RESET;
                        error_counter <= error_counter + 1;
                    end
                    else begin
                        state <= state;
                    end
                end
                S_01: begin
                    if (password[11:8]==number) begin
                        state <= S_010;
                    end 
                    else if (password[11:8]!==number) begin
                        state <= S_RESET;
                        error_counter <= error_counter + 1;
                    end
                    else begin
                        state <= state;
                    end
                end
                S_010: begin
                    if (password[7:4]==number) begin
                        state <= S_0101;
                    end 
                    else if (password[7:4]!==number) begin
                        state <= S_RESET;
                        error_counter <= error_counter + 1;
                    end
                    else begin
                        state <= state;
                    end
                end
                S_0101: begin
                    if (password[3:0]==number) begin
                        state <= S_01011;
                    end 
                    else if (password[3:0]!==number) begin
                        state <= S_RESET;
                        error_counter <= error_counter + 1;
                    end
                    else begin
                        state <= state;
                    end
                end
                S_01011: begin
                    state <= (b0) ? S_CHANGE_PASSWORD : (b1) ? S_RESET : state;
                    // w_state = (b0) ? S_CHANGE_PASSWORD : 14241 ? S_RESET : state;
                    // w_state2 = (w_state == 14241) ? S_RESET : state;
                    // state <= w_state2; 
                    error_counter <= 3'b000;
                end
                S_CHANGE_PASSWORD: begin
                            password <= {password[15:0], number};
                            if (counter<3'b100) begin
                                counter <= counter + 3'b001;
                                state <= state;
                            end
                            else begin
                            state <= S_RESET;
                            counter <=3'b000;
                            end
                end
                default: state <= S_RESET;
            endcase
        end
    end
    else begin
        if(error_counter>=4'b0101 && error_counter<4'b1111) begin
            error_counter <= error_counter + 1;
        end
        else begin
            error_counter <= 4'b0000;
        end
    end
end
   
assign out = (state == S_01011);
assign hex_display = {1'b0, state};
endmodule
