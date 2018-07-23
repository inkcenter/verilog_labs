run: compile simulate

run_hier:
	vcs -R -sverilog -debug_all +lint=TFIPC-L -f v_top.f -l run_hier.log

compile:
	vcs \
	-sverilog \
	-debug_all \
	-l com.log \
	+lint=TFIPC-L #print out detailed information of unconnected ports
	-f v_list.f

simulate:
	./simv +ntb_random_seed=$(SEED) -l sim.log

dve:
	dve -vpd vcdplus.vpd &

clean:
	rm -rf csrc* simv* *.tmp *.key *.vpd *.log DVEfiles coverage *.vdb *hdrs.v core.*
