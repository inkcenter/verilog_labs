module clock_switch(
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


//clk_800M synchronize clk_500M
  always @ (posedge clk_800M or negedge rst_n) begin
    if (!rst_n) begin
      sel0_clk800_y0 <= 1'b0;
    end else begin
      sel0_clk800_y0 <= ~(clk_sel[0] || sel0_clk500_y1); //clk_500M
    end
  end
  always @ (negedge clk_800M or negedge rst_n) begin
    if (!rst_n) begin
      sel0_clk800_y1 <= 1'b0;
    end else begin
      sel0_clk800_y1 <= sel0_clk800_y0;
    end
  end
//clk_500M synchronize clk_800M
  always @ (posedge clk_500M or negedge rst_n) begin
    if (!rst_n) begin
      sel0_clk500_y0 <= 1'b0;
    end else begin
      sel0_clk500_y0 <= ~((~clk_sel[0]) || sel0_clk800_y1); //clk_800M
    end
  end
  always @ (negedge clk_500M or negedge rst_n) begin
    if (!rst_n) begin
      sel0_clk500_y1 <= 1'b0;
    end else begin
      sel0_clk500_y1 <= sel0_clk500_y0;
    end
  end


//clk_800M synchronize clk_1000M
  always @ (posedge clk_800M or negedge rst_n) begin
    if (!rst_n) begin
      sel1_clk800_y0 <= 1'b0;
    end else begin
      sel1_clk800_y0 <= ~(clk_sel[1] || sel1_clk1000_800_y1); //clk_1000M
    end
  end
  always @ (negedge clk_800M or negedge rst_n) begin
    if (!rst_n) begin
      sel1_clk800_y1 <= 1'b0;
    end else begin
      sel1_clk800_y1 <= sel1_clk800_y0;
    end
  end
//clk_1000M synchronize clk_800M
  always @ (posedge clk_1000M or negedge rst_n) begin
    if (!rst_n) begin
      sel1_clk1000_800_y0 <= 1'b0;
    end else begin
      sel1_clk1000_800_y0 <= ~((~clk_sel[1]) || sel1_clk800_y1); //clk_800M
    end
  end
  always @ (negedge clk_1000M or negedge rst_n) begin
    if (!rst_n) begin
      sel1_clk1000_800_y1 <= 1'b0;
    end else begin
      sel1_clk1000_800_y1 <= sel1_clk1000_800_y0;
    end
  end


//clk_500M synchronize clk_1000M
  always @ (posedge clk_500M or negedge rst_n) begin
    if (!rst_n) begin
      sel1_clk500_y0 <= 1'b0;
    end else begin
      sel1_clk500_y0 <= ~(clk_sel[1] || sel1_clk1000_500_y1); //clk_1000M
    end
  end
  always @ (negedge clk_500M or negedge rst_n) begin
    if (!rst_n) begin
      sel1_clk500_y1 <= 1'b0;
    end else begin
      sel1_clk500_y1 <= sel1_clk500_y0;
    end
  end
//clk_1000M synchronize clk_500M
  always @ (posedge clk_1000M or negedge rst_n) begin
    if (!rst_n) begin
      sel1_clk1000_500_y0 <= 1'b0;
    end else begin
      sel1_clk1000_500_y0 <= ~((~clk_sel[1]) || sel1_clk500_y1); //clk_500M
    end
  end
  always @ (negedge clk_1000M or negedge rst_n) begin
    if (!rst_n) begin
      sel1_clk1000_500_y1 <= 1'b0;
    end else begin
      sel1_clk1000_500_y1 <= sel1_clk1000_500_y0;
    end
  end

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
