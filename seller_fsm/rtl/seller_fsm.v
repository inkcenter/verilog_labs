module seller_fsm(
  output reg [2:0] change,
  output reg       goods,

  input  wire      clk,
  input  wire      rst_n,
  input  wire      one,
  input  wire      two,
  input  wire      five
);
  parameter [3:0] IDLE   = 4'b0000,
                  ONE    = 4'b0001,
                  TWO    = 4'b0010,
                  THREE  = 4'b0011,
                  FOUR   = 4'b0100,
                  FIVE   = 4'b0101,
                  SIX    = 4'b0110,
                  SEVEN  = 4'b0111;

//  parameter [2:0] PLUS    = 3'100,   //plus one
//                  PLUSS   = 3'010,   //plus two
//                  PLUSSS  = 3'001;   //plus five

  reg  [3:0] curr_state;
  reg  [3:0] next_state;
//  wire [2:0] throw_money;
//  assign thow_money = {one,two,five};

  always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) curr_state <= IDLE;
    else        curr_state <= next_state;
  end

  always @ (curr_state, one, two, five) begin
    case (curr_state)
      IDLE: begin
        if      (one)  begin next_state = ONE;   change = 0; goods = 0; end
        else if (two)  begin next_state = TWO;   change = 0; goods = 0; end
        else if (five) begin next_state = FIVE;  change = 0; goods = 0; end
        else           begin next_state = IDLE;  change = 0; goods = 0; end
      end
      ONE: begin
        if      (one)  begin next_state = TWO;   change = 0; goods = 0; end
        else if (two)  begin next_state = THREE; change = 0; goods = 0; end
        else if (five) begin next_state = SIX;   change = 0; goods = 0; end
        else           begin next_state = ONE;   change = 0; goods = 0; end
      end
      TWO: begin
        if      (one)  begin next_state = THREE; change = 0; goods = 0; end
        else if (two)  begin next_state = FOUR;  change = 0; goods = 0; end
        else if (five) begin next_state = SEVEN; change = 0; goods = 0; end
        else           begin next_state = TWO;   change = 0; goods = 0; end
      end
      THREE: begin
        if      (one)  begin next_state = FOUR;  change = 0; goods = 0; end
        else if (two)  begin next_state = FIVE;  change = 0; goods = 0; end
        else if (five) begin next_state = IDLE;  change = 0; goods = 1; end //change=$0  goods=1
        else           begin next_state = THREE; change = 0; goods = 0; end
      end
      FOUR: begin
        if      (one)  begin next_state = FIVE;  change = 0; goods = 0; end
        else if (two)  begin next_state = SIX;   change = 0; goods = 0; end
        else if (five) begin next_state = IDLE;  change = 1; goods = 1; end //change=$10 goods=1
        else           begin next_state = FOUR;  change = 0; goods = 0; end
      end
      FIVE: begin
        if      (one)  begin next_state = SIX;   change = 0; goods = 0; end
        else if (two)  begin next_state = SEVEN; change = 0; goods = 0; end
        else if (five) begin next_state = IDLE;  change = 2; goods = 1; end //change=$20 goods=1
        else           begin next_state = FIVE;  change = 0; goods = 0; end
      end
      SIX: begin
        if      (one)  begin next_state = SEVEN; change = 0; goods = 0; end
        else if (two)  begin next_state = IDLE;  change = 0; goods = 1; end //change=$0  goods=1
        else if (five) begin next_state = IDLE;  change = 3; goods = 1; end //change=$30 goods=1
        else           begin next_state = SIX;   change = 0; goods = 0; end
      end
      SEVEN: begin
        if      (one)  begin next_state = IDLE;  change = 0; goods = 1; end //change=$0  goods=1
        else if (two)  begin next_state = IDLE;  change = 1; goods = 1; end //change=$10 goods=1
        else if (five) begin next_state = IDLE;  change = 4; goods = 1; end //change=$40 goods=1
        else           begin next_state = SEVEN; change = 0; goods = 0; end
      end
      default:         begin next_state = IDLE;  change = 0; goods = 0; end
    endcase
  end

endmodule

      
      
      
      
      
      
      
      
      
      


