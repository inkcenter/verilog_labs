create_clock -name clk_800  -period 10    [get_ports clk_800]
create_clock -name clk_500  -period 35    [get_ports clk_500]
create_clock -name clk_1000 -period 55    [get_ports clk_1000]
create_clock -name VCLK     -period 100
create_clock -name clk_scan -period 10000 [get_ports clk_scan]

create_generated_clock -name clk_out \
    -source [get_pins icg_1000/Q] \
    -master [get_clocks clk_1000] -add \
    -divide_by 1 \
    [get_ports clk_out]

set_clock_groups -name G1 -async -group {clk_800}
set_clock_groups -name G2 -async -group {clk_500}
set_clock_groups -name G3 -async -group {clk_1000}
set_clock_groups -name G4 -async -group {VCLK}
set_clock_groups -name G5 -async -group {clk_scan}
set_clock_groups -name G6 -async -group {clk_out}

set_input_delay -clock VCLK 2 [get_ports clk_sel]
