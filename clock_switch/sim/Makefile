RTL  = ./../rtl/clock_switch.v
TB   = ./../tb/clock_switch_tb.v
TIME = ./../tb/timescale.v

RTL_hier = ./../rtl/clock_switch_hier.v
TB_hier  = ./../tb/clock_switch_hier_tb.v

run: compile simulate

run_hier:
	vcs -R -sverilog -debug_all $(TIME) $(RTL_hier) $(TB_hier) -l run.log

compile:
	vcs -sverilog -debug_all $(TIME) $(RTL) $(TB) -l com.log

simulate:
	./simv +ntb_random_seed=$(SEED) -l sim.log

dve:
	dve -vpd vcdplus.vpd &

clean:
	rm -rf csrc* simv* *.tmp *.key *.vpd *.log DVEfiles coverage *.vdb *hdrs.v core.*
