module linebuffer
#(parameter ADDR_WIDTH = 11, DATA_WIDTH = 16, LENGTH = 1920)
(   output [DATA_WIDTH-1:0] data_out,
    output                  out_valid,
    input  [DATA_WIDTH-1:0] data_in,
    input                   in_valid,
    input                   clk,
    input                   rst_n
);

reg [ADDR_WIDTH-1:0] addr_cnt;
//control logic
reg in_valid_reg;
always @ (posedge clk) begin
    if (!rst_n) begin
        in_valid_reg <= #1 0;
    end else begin
        in_valid_reg <= #1 in_valid;
    end
end
wire full = (addr_cnt == LENGTH-1);
wire read = in_valid_reg && full;
//address
always @ (posedge clk) begin
  if (!rst_n) begin
      addr_cnt <= #1 0;
  end else if (in_valid_reg) begin
    if (!full) begin
      addr_cnt <= #1 addr_cnt + 1;
    end else begin
      addr_cnt <= #1 0;
    end
  end
end
//write enable RAM1 & read enable RAM2
reg  w_en_1, w_en_reg;
wire w_en_2 = ~w_en_1;
always @ (posedge clk) begin
    if (!rst_n) begin
        w_en_1 <= #1 1;
    end else begin
        if (read) begin
            w_en_1 <= #1 ~w_en_1;
        end
        w_en_reg <= #1 w_en_1;
    end
end
//data output select, additional 1 clock cycle
wire [DATA_WIDTH-1:0] data_ram_1;
wire [DATA_WIDTH-1:0] data_ram_2;
assign data_out = (!w_en_reg) ? data_ram_1 : data_ram_2;

//output valid
reg out_valid_reg;
assign out_valid = out_valid_reg;
always @ (posedge clk) begin
  if (!rst_n) begin
    out_valid_reg <= #1 0;
  end else if (full) begin
    out_valid_reg <= #1 1;
  end
end
//RAM instance
RAM_SINGLE_rst #( .ADDR_WIDTH(ADDR_WIDTH),
                  .DATA_WIDTH(DATA_WIDTH),
                  .LENGTH(LENGTH)
                )
  u1_RAM_SINGLE_rst (
    .data_out    (data_ram_1),
    .data_in     (data_in   ),
    .addr        (addr_cnt  ),
    .w_en        (w_en_1    ),
    .clk         (clk       ),
    .rst_n       (rst_n     )
  );

RAM_SINGLE_rst #( .ADDR_WIDTH(ADDR_WIDTH),
                  .DATA_WIDTH(DATA_WIDTH),
                  .LENGTH(LENGTH)
                )
  u2_RAM_SINGLE_rst (
    .data_out    (data_ram_2),
    .data_in     (data_in   ),
    .addr        (addr_cnt  ),
    .w_en        (w_en_2    ),
    .clk         (clk       ),
    .rst_n       (rst_n     )
  );

endmodule
