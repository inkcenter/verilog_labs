module clock_switch_tb;

parameter CLK_PERIOD_0 = 125, CLK_PERIOD_1 = 200, CLK_PERIOD_2 = 100;
parameter DLY = 10;

reg clk_800M, clk_500M, clk_1000M;
reg [1:0] clk_sel;
reg       rst_n;
wire      clk_out;

//instantiate
clock_switch 
  u_clock_switch( .clk_out(clk_out), 
                  .clk_800M(clk_800M), 
                  .clk_500M(clk_500M), 
                  .clk_1000M(clk_1000M), 
                  .clk_sel(clk_sel), 
                  .rst_n(rst_n)
                );

initial fork
           clk_800M  = 0; //phase difference generate
  #(DLY*2) clk_500M  = 0;
  #(DLY*4) clk_1000M = 0;
  forever #(CLK_PERIOD_0/2) clk_800M  = ~clk_800M;
  forever #(CLK_PERIOD_1/2) clk_500M  = ~clk_500M;
  forever #(CLK_PERIOD_2/2) clk_1000M = ~clk_1000M;
join

//always #(CLK_PERIOD_0/2) clk_800M  = ~clk_800M;
//always #(CLK_PERIOD_1/2) clk_500M  = ~clk_500M;
//always #(CLK_PERIOD_2/2) clk_1000M = ~clk_1000M;

initial begin
      clk_sel = 2'b00;
      rst_n   = 1'b1;
#100  rst_n   = 1'b0;
#100  rst_n   = 1'b1;
#100  clk_sel = 2'b00;
#1010 clk_sel = 2'b01;
#1010 clk_sel = 2'b10;
#1010 clk_sel = 2'b00;
#1010 clk_sel = 2'b10;
#1010 clk_sel = 2'b01;
#1010 clk_sel = 2'b00;
#1000 $finish;
end

initial begin
  $vcdpluson();
end

endmodule
