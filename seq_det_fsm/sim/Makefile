RTL  = ./../rtl/seq_det_fsm.v
TB   = ./../tb/seq_det_fsm_tb.v
TIME = ./../tb/timescale.v

RTL_MEALY = ./../rtl/seq_det_fsm_mealy.v
TB_MEALY  = ./../tb/seq_det_fsm_mealy_tb.v

run: compile simulate

run_mealy:
	vcs -R -sverilog -debug_all ${TIME} ${RTL_MEALY} ${TB_MEALY} -l run_mealy.log

compile:
	vcs -sverilog -debug_all $(TIME) $(RTL) $(TB) -l com.log

simulate:
	./simv +ntb_random_seed=$(SEED) -l sim.log

dve:
	dve -vpd vcdplus.vpd &

clean:
	rm -rf csrc* simv* *.tmp *.key *.vpd *.log DVEfiles coverage *.vdb *hdrs.v core.*
