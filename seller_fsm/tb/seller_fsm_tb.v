module seller_fsm_moore_tb;
  
  reg clk, rst_n, one, two, five;
  wire [2:0] change;
  wire       goods;

  //instantiate
  seller_fsm 
    u_seller_fsm ( .change(change),
                   .goods(goods),
                   .clk(clk),
                   .rst_n(rst_n),
                   .one(one),
                   .two(two),
                   .five(five)
                 );

  parameter CLOCK_PERIOD = 20;
  //clock generate
  initial begin
    clk = 0;
    forever begin
      #(CLOCK_PERIOD/2) clk = ~clk;
    end
  end

  task reset; begin
    rst_n = 0;
    @(posedge clk);
    rst_n = 1;
    @(posedge clk);
    @(posedge clk);
  end
  endtask

  task input_one; begin
    one = 1;
    @(posedge clk);
    one = 0;
    @(posedge clk);
  end
  endtask

  task input_two; begin
    two = 1;
    @(posedge clk);
    two = 0;
    @(posedge clk);
  end
  endtask
  
  task input_five; begin
    five = 1;
    @(posedge clk);
    five = 0;
    @(posedge clk);
  end
  endtask




  //stimulate
  initial begin
    #1   one    = 0;
         two    = 0;
         five   = 0;
         rst_n  = 1;

    reset;
    input_one;
    input_two;
    input_five; //10+20+50

    reset;
    input_two;
    input_two;
    input_two;
    input_two;  //20+20+20+20
    
    reset;
    input_five;
    input_five; //50+50

    reset;
    input_two;
    input_two;
    input_five; //20+20+50

    reset;
    input_five;
    input_one;
    input_one;
    input_one;
    input_one; //50+10+10+10+10

    reset;
    input_two;
    input_two;
    input_two;
    input_five; //20+20+20+50

    reset;
    input_five;
    input_two;
    input_five; //50+20+50

    input_one;

    #100 $finish;
  end

  always @ (posedge clk or negedge rst_n) begin
    if (!rst_n)          $display ("%t:%m: resetting...", $time);
    else if (goods == 1) $display ("Putting goods out, here is your change: $%d", change*10);
  end

  initial begin
    $vcdpluson();
  end
  
endmodule
