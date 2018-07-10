module seq_det_fsm_tb;

reg clk, rst_n, seq_in;
wire flag;

//instantiate
seq_det_fsm_mealy 
  u_seq_det_fsm_mealy( .flag(flag),
                 .clk(clk),
                 .rst_n(rst_n),
                 .seq_in(seq_in)
               );

parameter CLOCK_PERIOD = 20;

//clock generate
initial begin
  clk = 0;
  forever begin
    #(CLOCK_PERIOD/2) clk = ~clk;
  end
end


task target_seq; begin
  #20 seq_in = 1;
  #20 seq_in = 0;
  #20 seq_in = 1;
  #20 seq_in = 1;
  #20 seq_in = 0;
  #20 seq_in = 1;
  #20 seq_in = 0; //1011010 flag=1
end
endtask

//stimulate
initial begin
  #1 seq_in = 0;
     rst_n  = 1;
  #5 rst_n  = 0; //reset
  #5 rst_n  = 1;

  target_seq;

  #20 seq_in = 1;
  #20 seq_in = 1;
  #20 seq_in = 0;
  #20 seq_in = 1;
  #20 seq_in = 0;
  #20 seq_in = 0;
  #20 seq_in = 1; //1101001

  #20 seq_in = 1;
  #20 seq_in = 0;
  #20 seq_in = 1;
  #20 seq_in = 0;
  #20 seq_in = 1;
  #20 seq_in = 1;
  #20 seq_in = 1; //1010111

  #20 seq_in = 1;
  #20 seq_in = 0;
  #20 seq_in = 1;
  #20 seq_in = 0;
  #1  rst_n  = 0; //reset
  #5  rst_n  = 1; 

  target_seq;
  #20 seq_in = 1;
  #20 seq_in = 1;
  #20 seq_in = 0;
  #20 seq_in = 1;
  #20 seq_in = 0; //overlap flag=1

  #100 $finish;
end

//dump
initial begin
  $vcdpluson();
end

always @ (posedge clk or negedge rst_n) begin
  if      (!rst_n)  $display ("%t:%m: resetting...", $time);
  else if (flag==1) $display ("Sequence 1011010 detected");
end

endmodule
