module RAM_DUAL_pseudo
#(parameter ADDR_WIDTH = 10, DATA_WIDTH = 16)(
  output reg [DATA_WIDTH-1:0] data_out,
  input      [DATA_WIDTH-1:0] data_in,
  input      [ADDR_WIDTH-1:0] r_addr,
  input                       r_en,
  input                       r_clk,
  input      [ADDR_WIDTH-1:0] w_addr,
  input                       w_en,
  input                       w_clk
);

localparam RAM_DEPTH = (1 << ADDR_WIDTH);

reg [DATA_WIDTH-1:0] memory [RAM_DEPTH-1:0];

always @ (posedge w_clk) begin
  if (w_en) begin
    memory[w_addr] <= data_in;
  end
end

always @ (posedge r_clk) begin
  if (r_en) begin
    data_out <= memory[r_addr];
  end
end

endmodule
