set search_path ". $search_path ./../library"

set target_library sc_max.db
set link_library "* $target_library"

set myClk    clk
set myDesign counter10
set myFiles  [list ./../rtl/${myDesign}.v]

define_design_lib WORK -path ./WORK

analyze -work WORK -format verilog $myFiles

elaborate -work WORK $myDesign

#set_operating_conditions   typical
#set_wire_load_model -name "tsmc090_wl10" [all_designs]

source ./syn.sdc

ungroup -all -flatten

compile -map_effort high

report_timing > ${myDesign}_timing.rpt
report_area   > ${myDesign}_area.rpt
report_qor    > ${myDesign}_qor.rpt

write -hierarchy -format ddc

write -hierarchy -format verilog -output ${myDesign}_netlist.v

#write_sdf test.sdf
#write_sdf test.sdf
