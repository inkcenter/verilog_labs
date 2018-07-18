RTL  = ./../rtl/clock_switch.v
TB   = ./../tb/clock_switch_tb.v
TIME = ./../tb/timescale.v

RTL_task = ./../rtl/clock_switch_task.v
TB_task  = ./../tb/clock_switch_task_tb.v

run: compile simulate

run_task:
	vcs -R -sverilog -debug_all $(TIME) $(RTL) $(TB) -l run.log

compile:
	vcs -sverilog -debug_all $(TIME) $(RTL) $(TB) -l com.log

simulate:
	./simv +ntb_random_seed=$(SEED) -l sim.log

dve:
	dve -vpd vcdplus.vpd &

clean:
	rm -rf csrc* simv* *.tmp *.key *.vpd *.log DVEfiles coverage *.vdb *hdrs.v core.*
