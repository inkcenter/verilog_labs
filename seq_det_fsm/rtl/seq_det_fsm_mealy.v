module seq_det_fsm_mealy(
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
                S6   = 3'b110;

reg [2:0] curr_state;
reg [2:0] next_state;
reg       flag;

always @ (posedge clk or negedge rst_n) begin
   if (!rst_n) curr_state <= IDLE;
   else        curr_state <= next_state;
end

always @ (curr_state, seq_in) begin
  case (curr_state)
    IDLE: if (seq_in==1) begin next_state = S1;   flag = 0; end
          else           begin next_state = IDLE; flag = 0; end
    S1  : if (seq_in==0) begin next_state = S2;   flag = 0; end
          else           begin next_state = S1;   flag = 0; end
    S2  : if (seq_in==1) begin next_state = S3;   flag = 0; end
          else           begin next_state = IDLE; flag = 0; end
    S3  : if (seq_in==1) begin next_state = S4;   flag = 0; end
          else           begin next_state = S2;   flag = 0; end
    S4  : if (seq_in==0) begin next_state = S5;   flag = 0; end
          else           begin next_state = S1;   flag = 0; end
    S5  : if (seq_in==1) begin next_state = S6;   flag = 0; end
          else           begin next_state = IDLE; flag = 0; end
    S6  : if (seq_in==0) begin next_state = S2;   flag = 1; end
          else           begin next_state = S4;   flag = 0; end
    default :            begin next_state = IDLE; flag = 0; end
  endcase
end

endmodule
