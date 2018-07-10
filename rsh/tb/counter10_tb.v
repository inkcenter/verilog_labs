module counter10_tb;

  reg clockTest, reset_nTest, enableTest, loadTest;
  reg  [3:0] dinTest;
  wire [3:0] doutTest;
  wire       coutTest;

  parameter CLOCK_PERIOD = 10;

  //instantiate
  counter10 u_counter10 ( .dout(doutTest),
                          .cout(coutTest),
                          .clock(clockTest),
                          .reset_n(reset_nTest),
                          .enable(enableTest),
                          .load(loadTest),
                          .din(dinTest)
                        );

  //clock generate
  initial begin
    clockTest = 0;
    forever begin
      #(CLOCK_PERIOD/2) clockTest = ~clockTest;
    end
  end

  //stimulate
  initial begin
    #01 enableTest  = 'b0;
        loadTest    = 'b0;
        dinTest     = 'b0;
        reset_nTest = 1'b1; //reset
    #10 reset_nTest = 1'b0;
    #10 reset_nTest = 1'b1;
    #01 loadTest    = 1'b1; //load
        enableTest  = 1'b1;
    #01 dinTest     = 4'd7;
    #10 loadTest    = 1'b0;
    #50 dinTest     = 'b0;
        reset_nTest = 1'b0;
    #10 reset_nTest = 1'b1; //reset
    #300 $finish;
  end
  
  //print
  always @ (posedge clockTest) begin
    if (!reset_nTest) begin
      $display ("%t:%m: resetting...", $time);
    end else if (loadTest) begin
        $display ("%t:%m: loading %b in....", $time, dinTest);
    end
  end


  //dump
  initial begin
    $vcdpluson();
  end

endmodule

