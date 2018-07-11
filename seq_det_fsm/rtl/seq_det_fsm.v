module seq_det_fsm(
  output flag,
  input  clk,
  input  rst_n,
  input  seq_in
);

parameter [2:0] IDLE = 3'b000,
                S1   = 3'b001,
                S2   = 3'b010,
                S3   = 3'b011,
                S4   = 3'b100,
                S5   = 3'b101,
                S6   = 3'b110,
                S7   = 3'b111;

reg [2:0] curr_state;
reg [2:0] next_state;

always @ (posedge clk or negedge rst_n) begin
   if (!rst_n) curr_state <= IDLE;
   else        curr_state <= next_state;
end

always @ (curr_state, seq_in) begin
  case (curr_state)
    IDLE: if (seq_in==1) next_state = S1;
          else           next_state = IDLE;
    S1  : if (seq_in==0) next_state = S2;
          else           next_state = S1;
    S2  : if (seq_in==1) next_state = S3;
          else           next_state = IDLE;
    S3  : if (seq_in==1) next_state = S4;
          else           next_state = S2;
    S4  : if (seq_in==0) next_state = S5;
          else           next_state = S1;
    S5  : if (seq_in==1) next_state = S6;
          else           next_state = IDLE;
    S6  : if (seq_in==0) next_state = S7;
          else           next_state = S4;
    S7  : if (seq_in==1) next_state = S3;
          else           next_state = IDLE;
    default:             next_state = IDLE;
  endcase
end

assign flag = (curr_state==S7) ? 1'b1 : 1'b0;

endmodule






