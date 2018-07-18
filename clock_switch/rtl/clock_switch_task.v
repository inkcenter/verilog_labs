module clock_switch_task(
  output clk_out,
  input clk_800M,      //clocks are asynchronus
  input clk_500M,
  input clk_1000M,
  input [1:0] clk_sel,
  input rst_n
);

  wire G001, G102, G010, G112, G120, G121;
  wire G0, G1, G2;

  reg sel0_clk800_y0,  sel0_clk800_y1;  //clk_800M synchronize clk_500M
  reg sel0_clk500_y0,  sel0_clk500_y1;  //clk_500M synchronize clk_800M
  reg sel1_clk800_y0,  sel1_clk800_y1;  //clk_800M synchronize clk_1000M
  reg sel1_clk1000_800_y0, sel1_clk1000_800_y1;
                                        //clk_1000M synchronize clk_800M
  reg sel1_clk500_y0,  sel1_clk500_y1;  //clk_500M synchronize clk_1000M
  reg sel1_clk1000_500_y0, sel1_clk1000_500_y1;
                                        //clk_1000M synchronize clk_500M

//clk_sel_bit synchronized for clkA crossing clkA and clkB
task SyncClk(
  output sel_clkA_y0, 
  output sel_clkA_y1,
  input  sel_clkB_y1,
  input  clk_sel_bit,
  input  clkA,
  input  rst_n
);
begin
  always @ (posedge clkA or negedge rst_n) begin
    if (!rst_n) begin
      sel_clkA_y0 <= 1'b0;
    end else begin
      sel_clkA_y0 <= ~(clk_sel_bit || sel_clkB_y1); //clk_500M
    end
  end
  always @ (negedge clkA or negedge rst_n) begin
    if (!rst_n) begin
      sel_clkA_y1 <= 1'b0;
    end else begin
      sel_clkA_y1 <= sel_clkA_y0;
    end
  end
end
endtask

//clk_sel synchronized for clk_800M and clk_500M
SyncClk ( .sel_clkA_y0(sel0_clk800_y0),
          .sel_clkA_y1(sel0_clk800_y1),
          .sel_clkB_y1(sel0_clk500_y1),
          .clk_sel_bit(clk_sel[0]),
          .clkA       (clk_800M),
          .rst_n      (rst_n)
        );
SyncClk ( .sel_clkA_y0(sel0_clk500_y0),
          .sel_clkA_y1(sel0_clk500_y1),
          .sel_clkB_y1(sel0_clk800_y1),
          .clk_sel_bit(clk_sel[0]),
          .clkA       (clk_500M),
          .rst_n      (rst_n)
        );
//clk_sel synchronized for clk_800M and clk_1000M
SyncClk ( .sel_clkA_y0(sel1_clk800_y0),
          .sel_clkA_y1(sel1_clk800_y1),
          .sel_clkB_y1(sel1_clk1000_y1),
          .clk_sel_bit(clk_sel[1]),
          .clkA       (clk_800M),
          .rst_n      (rst_n)
        );
SyncClk ( .sel_clkA_y0(sel1_clk1000_y0),
          .sel_clkA_y1(sel1_clk1000_y1),
          .sel_clkB_y1(sel1_clk800_y1),
          .clk_sel_bit(clk_sel[1]),
          .clkA       (clk_1000M),
          .rst_n      (rst_n)
        );
//clk_sel synchronized for clk_500M and clk_1000M
SyncClk ( .sel_clkA_y0(sel1_clk500_y0),
          .sel_clkA_y1(sel1_clk500_y1),
          .sel_clkB_y1(sel1_clk1000_y1),
          .clk_sel_bit(clk_sel[1]),
          .clkA       (clk_500M),
          .rst_n      (rst_n)
        );
SyncClk ( .sel_clkA_y0(sel1_clk1000_y0),
          .sel_clkA_y1(sel1_clk1000_y1),
          .sel_clkB_y1(sel1_clk500_y1),
          .clk_sel_bit(clk_sel[1]),
          .clkA       (clk_1000M),
          .rst_n      (rst_n)
        );

assign G001 = sel0_clk800_y1;
assign G010 = sel0_clk500_y1;
assign G102 = sel1_clk800_y1;
assign G112 = sel1_clk500_y1;
assign G120 = sel1_clk1000_800_y1;
assign G121 = sel1_clk1000_500_y1;

assign G0   = clk_800M  && G001 && G102;
assign G1   = clk_500M  && G010 && G112;
assign G2   = clk_1000M && (G120 || G121);

assign clk_out = G0 || G1 || G2;

endmodule
