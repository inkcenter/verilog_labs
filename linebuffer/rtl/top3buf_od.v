module top3buf
#(parameter ADDR_WIDTH = 7, DATA_WIDTH = 16, LENGTH = 100)
(   output [DATA_WIDTH-1:0] data_out_0,
    output [DATA_WIDTH-1:0] data_out_1,
    output [DATA_WIDTH-1:0] data_out_2,
    output                  out_valid,
    input  [DATA_WIDTH-1:0] data_in,
    input                   in_valid,
    input                   clk,
    input                   rst_n
);

wire [DATA_WIDTH-1:0] data_buf_0, data_buf_1;
wire out_valid_0, out_valid_1;

//calibrate
reg [DATA_WIDTH-1:0] out_valid_reg;                  // 1 cycle
reg [DATA_WIDTH-1:0] data_out_1_reg;                 // 1 cycle
reg [DATA_WIDTH-1:0] data_out_2_tmp, data_out_2_reg; // 2 cycle
always @ (posedge clk) begin
    if (!rst_n) begin
        out_valid_reg  <= #1 0;
        data_out_1_reg <= #1 0;
        data_out_2_tmp <= #1 0;
        data_out_2_reg <= #1 0;
    end else begin
        out_valid_reg  <= #1 out_valid_0;
        data_out_1_reg <= #1 data_buf_1;
        data_out_2_tmp <= #1 data_in;
        data_out_2_reg <= #1 data_out_2_tmp;
    end
end
assign out_valid  = out_valid_reg;
assign data_out_2 = data_out_2_reg;
assign data_out_1 = data_out_1_reg;
assign data_out_0 = data_buf_0;

linebuffer #( .ADDR_WIDTH(ADDR_WIDTH),
              .DATA_WIDTH(DATA_WIDTH),
              .LENGTH(LENGTH)
            )
  u1_linebuffer (
    .data_out   (data_buf_1  ), 
    .out_valid  (out_valid_1 ), 
    .data_in    (data_in     ), 
    .in_valid   (in_valid    ), 
    .clk        (clk         ), 
    .rst_n      (rst_n       )
  );

linebuffer #( .ADDR_WIDTH(ADDR_WIDTH),
              .DATA_WIDTH(DATA_WIDTH),
              .LENGTH(LENGTH)
            )
  u0_linebuffer (
    .data_out   (data_buf_0  ), 
    .out_valid  (out_valid_0 ), 
    .data_in    (data_buf_1  ), 
    .in_valid   (out_valid_1 ), 
    .clk        (clk         ), 
    .rst_n      (rst_n       )
  );

endmodule
