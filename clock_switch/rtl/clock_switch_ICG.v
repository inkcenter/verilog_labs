module clock_switch_ICG(
  output clk_out,
  input clk_800,      //clocks are asynchronus
  input clk_500,
  input clk_1000,
  input [1:0] clk_sel,
  input rst_clk_n,
  input dc_scan_mode,
  input icg_scan_mode,
  input clk_scan
);
//selection signals
wire sel_800  = (clk_sel[1:0] == 2'b00);
wire sel_500  = (clk_sel[1:0] == 2'b01);
wire sel_1000 = (clk_sel[1:0] == 2'b10) || (clk_sel[1:0] == 2'b11);
//enable signals synchoronize registers
reg en_800_sync0,  en_800_sync1,  en_800_sync2;
reg en_500_sync0,  en_500_sync1,  en_500_sync2;
reg en_1000_sync0, en_1000_sync1, en_1000_sync2;
//NOR feedback enable signals
wire use_800  = sel_800  | en_800_sync0  | en_800_sync1  | en_800_sync2;
wire use_500  = sel_500  | en_500_sync0  | en_500_sync1  | en_500_sync2;
wire use_1000 = sel_1000 | en_1000_sync0 | en_1000_sync1 | en_1000_sync2;

wire en_800  = ~use_500 & ~use_1000;
wire en_500  = ~use_800 & ~use_1000;
wire en_1000 = ~use_800 & ~use_500;
//dc scan mode
wire clk_800_scan  = dc_scan_mode ? clk_scan : clk_800;
wire clk_500_scan  = dc_scan_mode ? clk_scan : clk_500;
wire clk_1000_scan = dc_scan_mode ? clk_scan : clk_1000;
//synchoronize with 800MHz clock
always @ (posedge clk_800 or negedge rst_clk_n) begin
    if (!rst_clk_n) begin
        en_800_sync0 <= 1'b0;
        en_800_sync1 <= 1'b0;
        en_800_sync2 <= 1'b0;
    end else begin
        en_800_sync0 <= en_800;
        en_800_sync1 <= en_800_sync0;
        en_800_sync2 <= en_800_sync1;
    end
end

always @ (posedge clk_500 or negedge rst_clk_n) begin
    if (!rst_clk_n) begin
        en_500_sync0 <= 1'b0;
        en_500_sync1 <= 1'b0;
        en_500_sync2 <= 1'b0;
    end else begin
        en_500_sync0 <= en_500;
        en_500_sync1 <= en_500_sync0;
        en_500_sync2 <= en_500_sync1;
    end
end

always @ (posedge clk_1000 or negedge rst_clk_n) begin
    if (!rst_clk_n) begin
        en_1000_sync0 <= 1'b0;
        en_1000_sync1 <= 1'b0;
        en_1000_sync2 <= 1'b0;
    end else begin
        en_1000_sync0 <= en_1000;
        en_1000_sync1 <= en_1000_sync0;
        en_1000_sync2 <= en_1000_sync1;
    end
end
//instantiate ICG
//1000MHz for OCC 
//800MHZ & 500MHz for dft, clk_out = 0
wire clk_out_800, clk_out_500, clk_out_1000;
assign en_800_icg  = en_800_sync1 & ~dc_scan_mode;
assign en_500_icg  = en_500_sync1 & ~dc_scan_mode;
assign en_1000_icg = en_1000_sync1;

ICG icg_800 (.Q(clk_out_800), .CP(clk_800), .E(en_800_icg), .TE(icg_scan_mode));
ICG icg_500 (.Q(clk_out_500), .CP(clk_500), .E(en_500_icg), .TE(icg_scan_mode));
ICG icg_1000 (.Q(clk_out_1000), .CP(clk_1000), .E(en_1000_icg), .TE(icg_scan_mode));

assign clk_out = clk_out_800 | clk_out_500 | clk_out_1000;

endmodule

//integrated clock gate
module ICG(
  output Q,
  input  CP,
  input  E,
  input  TE
);

wire E_or = E | TE;
reg E_latch;

always @ (*) begin
  if (!CP) E_latch = E_or;
end

assign Q = E_latch & CP;

endmodule
