module RAM_SINGLE_rst
#(parameter ADDR_WIDTH = 11, DATA_WIDTH = 16, LENGTH=1920)
(   output [DATA_WIDTH-1:0] data_out,
    input  [DATA_WIDTH-1:0] data_in,
    input  [ADDR_WIDTH-1:0] addr,
    input  w_en,
    input  clk,
    input  rst_n
);

//localparam LENGTH = (1 << ADDR_WIDTH);
reg [DATA_WIDTH-1:0] memory [LENGTH-1:0];
reg [DATA_WIDTH-1:0] data_out_reg;
assign data_out = data_out_reg;

always @ (posedge clk or rst_n) begin
  if (!rst_n) begin: RESET_RAM
    integer i;
    for (i=0;i<LENGTH;i=i+1) begin
      memory[i] <= #1 0;
    end
    data_out_reg <= #1 0;
  end else begin
    if (w_en) begin
      memory[addr] <= #1 data_in;
    end else begin
      data_out_reg <= #1 memory[addr];
    end
  end
end
//assign data_out = (!w_en) ? memory[addr] : 0;

endmodule
