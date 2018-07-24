module clock_switch_hier(
  output clk_out,
  input clk_800M,      //clocks are asynchronus
  input clk_500M,
  input clk_1000M,
  input [1:0] clk_sel,
  input rst_n
);

  wire G001, G102, G010, G112, G120, G121;
  wire G0, G1, G2;

  wire sel0_clk800;      //clk_800M synchronize clk_500M
  wire sel0_clk500;      //clk_500M synchronize clk_800M
  wire sel1_clk800;      //clk_800M synchronize clk_1000M
  wire sel1_clk1000_800; //clk_1000M synchronize clk_800M
  wire sel1_clk500;      //clk_500M synchronize clk_1000M
  wire sel1_clk1000_500; //clk_1000M synchronize clk_500M

//clk_sel synchronized for clk_800M and clk_500M
SyncClk u_sel_800_500 ( .sel_clkA   (sel0_clk800),
                        .sel_clkB   (sel0_clk500),
                        .clk_sel_bit(clk_sel[0]),
                        .clkA       (clk_800M),
                        .rst_n      (rst_n)
                      );
SyncClk u_sel_500_800 ( .sel_clkA   (sel0_clk500),
                        .sel_clkB   (sel0_clk800),
                        .clk_sel_bit(~clk_sel[0]),
                        .clkA       (clk_500M),
                        .rst_n      (rst_n)
                      );
//clk_sel synchronized for clk_800M and clk_1000M
SyncClk u_sel_800_1000 ( .sel_clkA   (sel1_clk800),
                         .sel_clkB   (sel1_clk1000_800),
                         .clk_sel_bit(clk_sel[1]),
                         .clkA       (clk_800M),
                         .rst_n      (rst_n)
                       );
SyncClk u_sel_1000_800 ( .sel_clkA   (sel1_clk1000_800),
                         .sel_clkB   (sel1_clk800),
                         .clk_sel_bit(~clk_sel[1]),
                         .clkA       (clk_1000M),
                         .rst_n      (rst_n)
                       );
//clk_sel synchronized for clk_500M and clk_1000M
SyncClk u_sel_500_1000 ( .sel_clkA   (sel1_clk500),
                         .sel_clkB   (sel1_clk1000_500),
                         .clk_sel_bit(clk_sel[1]),
                         .clkA       (clk_500M),
                         .rst_n      (rst_n)
                       );
SyncClk u_sel_1000_500 ( .sel_clkA   (sel1_clk1000_500),
                         .sel_clkB   (sel1_clk500),
                         .clk_sel_bit(~clk_sel[1]),
                         .clkA       (clk_1000M),
                         .rst_n      (rst_n)
                       );

assign G001 = sel0_clk800;
assign G010 = sel0_clk500;
assign G102 = sel1_clk800;
assign G112 = sel1_clk500;
assign G120 = sel1_clk1000_800;
assign G121 = sel1_clk1000_500;

assign G0   = clk_800M  && G001 && G102;
assign G1   = clk_500M  && G010 && G112;
assign G2   = clk_1000M && (G120 || G121);

assign clk_out = G0 || G1 || G2;

endmodule

//clk_sel_bit synchronized for clkA crossing clkA and clkB
module SyncClk(
  output sel_clkA,
  input  sel_clkB,
  input  clk_sel_bit,
  input  clkA,
  input  rst_n
);

reg sel_clkA_y0, sel_clkA_y1;
assign sel_clkA = sel_clkA_y1;

  always @ (posedge clkA or negedge rst_n) begin
    if (!rst_n) begin
      sel_clkA_y0 <= 1'b0;
    end else begin
      sel_clkA_y0 <= ~(clk_sel_bit || sel_clkB); //clk_500M
    end
  end
  always @ (negedge clkA or negedge rst_n) begin
    if (!rst_n) begin
      sel_clkA_y1 <= 1'b0;
    end else begin
      sel_clkA_y1 <= sel_clkA_y0;
    end
  end

endmodule

