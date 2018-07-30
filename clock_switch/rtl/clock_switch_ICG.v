module clock_switch_ICG(
  output clk_out,
  input clk_800M,      //clocks are asynchronus
  input clk_500M,
  input clk_1000M,
  input [1:0] clk_sel,
  input rst_n
);

endmodule

module ICG(
  output clock_out,
  input  clock_in,
  input  clock_scan,
  input  en,
  input  en_scan
);

reg en_latch;

always @ (*) begin
  if (!clock_in) en_latch = en;
end

assign clock_out = en_latch && clock_in;

endmodule
