set search_path ". $search_path ./../library"

set target_library sc_max.db
set link_library "* $target_library"

set myClkA   r_clk
set myClkB   w_clk
set myDesign fifo_top
set myFiles  [list ./../rtl/${myDesign}.v \
                   ./../rtl/RAM_DUAL_rst.v \
                   ./../rtl/write.v \
                   ./../rtl/read.v \
                   ./../rtl/bin2gray.v \
                   ./../rtl/sync.v ]

set myConstr "./syn_mcp.sdc"

define_design_lib WORK -path ./WORK

analyze -work WORK -format verilog $myFiles

elaborate -work WORK $myDesign

#set_operating_conditions   typical
#set_wire_load_model -name "tsmc090_wl10" [all_designs]

source $myConstr

#ungroup -all -flatten

compile -map_effort high

report_timing > ${myDesign}_timing.rpt
report_area   > ${myDesign}_area.rpt
report_qor    > ${myDesign}_qor.rpt

write -hierarchy -format ddc

write -hierarchy -format verilog -output ${myDesign}_netlist.v

#write_sdf test.sdf
#write_sdf test.sdf
