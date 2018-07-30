module gfree3 (
clk_out,
cgm_sel,
clk_in0,
clk_in1,
clk_in2,
rst_clk_n,
scan_dc_mode,
icg_scan_mode,
clk_scan
);

output clk_out;

input [1:0] cgm_sel;
input clk_in0;
input clk_in1;
input clk_in2;
input rst_clk_n;
input icg_scan_mode;
input scan_dc_mode;
input clk_scan;

reg in0_en_sync1,in0_en_sync2,in0_en_sync3;
reg in1_en_sync1,in1_en_sync2,in1_en_sync3;
reg in2_en_sync1,in2_en_sync2,in2_en_sync3;

assign clk_in0_scan = scan_dc_mode ? clk_scan : clk_in0;
assign clk_in1_scan = scan_dc_mode ? clk_scan : clk_in1;
assign clk_in2_scan = scan_dc_mode ? clk_scan : clk_in2;

assign in0_sel = (cgm_sel[1:0] == 2'b00);
assign in1_sel = (cgm_sel[1:0] == 2'b01);
assign in2_sel = (cgm_sel[1:0] == 2'b10 || (cgm_sel[1:0] == 2'b11));

assign in0_used = in0_sel | in0_en_sync1 | in0_en_sync2 | in0_en_sync3;
assign in1_used = in1_sel | in1_en_sync1 | in1_en_sync2 | in1_en_sync3;
assign in2_used = in2_sel | in2_en_sync1 | in2_en_sync2 | in2_en_sync3;

assign in0_en = ~in1_used & ~in2_used;
assign in1_en = ~in0_used & ~in2_used;
assign in2_en = ~in0_used & ~in1_used;

always @(posedge clk_in0_scan or negedge rst_clk_n) begin
  if (!rst_clk_n) begin
    in0_en_sync1 <= 1'b0;
    in0_en_sync2 <= 1'b0;
    in0_en_sync3 <= 1'b0;
  end
  else begin
    in0_en_sync1 <= in0_en;
    in0_en_sync2 <= in0_en_sync1;
    in0_en_sync3 <= in0_en_sync2;
  end
end

always @(posedge clk_in1_scan or negedge rst_clk_n) begin
  if (!rst_clk_n) begin
    in1_en_sync1 <= 1'b0;
    in1_en_sync2 <= 1'b0;
    in1_en_sync3 <= 1'b0;
  end
  else begin
    in1_en_sync1 <= in1_en;
    in1_en_sync2 <= in1_en_sync1;
    in1_en_sync3 <= in1_en_sync2;
  end
end

always @(posedge clk_in2_scan or negedge rst_clk_n) begin
  if (!rst_clk_n) begin
    in2_en_sync1 <= 1'b0;
    in2_en_sync2 <= 1'b0;
    in2_en_sync3 <= 1'b0;
  end
  else begin
    in2_en_sync1 <= in2_en;
    in2_en_sync2 <= in2_en_sync1;
    in2_en_sync3 <= in2_en_sync2;
  end
end

assign ind_in0 = in0_en_sync2;
assign ind_in1 = in1_en_sync2;
assign ind_in2 = in2_en_sync2;

cell_ckgate u_clk_gate_out0 (
  .E (ind_in0),
  .CP (clk_in0),
  .TE (icg_scan_mode),
  .Q (clk_out0)
);

assign ind_in1_scan = ~scan_dc_mode & ind_in1;

cell_ckgate  u_clk_gate_out1 (
  .E (ind_in1_scan),
  .CP (clk_in1),
  .TE (icg_scan_mode),
  .Q (clk_out1)
);

 assign ind_in2_scan = ~scan_dc_mode & ind_in2;
 
 cell_ckgate  u_clk_gate_out2 (
   .E(ind_in2_scan),
   .CP (clk_in2),
   .TE (icg_scan_mode),
   .Q (clk_out2)
 );

assign clk_out = clk_out0 | clk_out1 | clk_out2 ;
endmodule


