module clock_switch_ICG_tb;

wire clk_out;
reg clk_800, clk_500, clk_1000;
reg [1:0] clk_sel;
reg rst_clk_n;
reg dc_scan_mode, icg_scan_mode;
reg clk_scan;

always #70   clk_800  = ~clk_800;
always #110  clk_500  = ~clk_500;
always #20   clk_1000 = ~clk_1000;
always #1000 clk_scan = ~clk_scan;

initial begin
    clk_800   = 0;
    clk_500   = 0;
    clk_1000  = 0;
    clk_scan  = 0;
    rst_clk_n = 0;
    dc_scan_mode  = 0;
    icg_scan_mode = 1;
    clk_sel = 1;
    #20000
    rst_clk_n = 1;
    dc_scan_mode  = 1;
    icg_scan_mode = 0;
    #20000
    rst_clk_n = 1;
    dc_scan_mode  = 0;
    icg_scan_mode = 0;

    clk_sel = 0;
    repeat(50) @(posedge clk_500);
    clk_sel = 1;
    repeat(50) @(posedge clk_500);
    clk_sel = 2;
    repeat(50) @(posedge clk_500);
    clk_sel = 1;
    repeat(50) @(posedge clk_500);
    clk_sel = 0;
    repeat(50) @(posedge clk_500);
    clk_sel = 2;
    repeat(50) @(posedge clk_500);
    clk_sel = 0;
    repeat(1000) @(posedge clk_500);
    $finish;
end

initial begin
//    $vcdpluson();
//    $vcdplusfile("clock_switch_ICG.vpd");
    $fsdbDumpfile("clock_switch_ICG.fsdb");
    $fsdbDumpvars(0,clock_switch_ICG_tb);
end

clock_switch_ICG 
    u_clock_swicth_ICG (
     .clk_out          (clk_out       ),       
     .clk_800          (clk_800       ), 
     .clk_500          (clk_500       ), 
     .clk_1000         (clk_1000      ), 
     .clk_sel          (clk_sel       ), 
     .rst_clk_n        (rst_clk_n     ), 
     .dc_scan_mode     (dc_scan_mode  ), 
     .icg_scan_mode    (icg_scan_mode ), 
     .clk_scan         (clk_scan      ) 
    );

endmodule

