create_clock -name clk_in0 -period 1 [get_ports clk_in0]
create_clock -name clk_in1 -period 2 [get_ports clk_in1]
create_clock -name clk_in2 -period 3 [get_ports clk_in2]
create_clock -name clk_scan -period 3 [get_ports clk_scan]
create_clock -name VCLK -period 4
create_geneated_clock -name clk_out \
  -source clk_in0 [get_ports clk_in0] \
  -divide_by 1 \
  [get_ports clk_out]

set_clock_groups G1 -async -group {clk_in0} 

set_clock_groups G2 -async -groups {clk_in1}
set_clock_groups G3 -async -group {clk_in2} 
set_clock_groups G4 -async -group {clk_out} 
set_clock_groups G5 -async -group clk_scan
set_clock_groups G5 -async -group VCLK

set_input_delay 2 -clock VCLK [get_ports cgm_sel]
