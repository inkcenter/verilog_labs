

copy_case:
	cp -rf ../tc/${TC}.v testcase.v

create_lib:
	vlib work

compile:
	vlog -l comp.log -f rtl.list -f tb.list

sim:
	vsim -l sim.log -c -novopt ahb_clac_top_tb -do "run -all"


clean:
	rm -rf csrc simv.daidir ucli.key vcdplus.vpd simv ccc


