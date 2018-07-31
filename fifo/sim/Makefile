run: compile simulate

run_hier:
	vcs -full64 -R -sverilog -debug_all +lint=TFIPC-L -f v_top.f -l run_hier.log

compile:
	vcs -full64\
	-sverilog \
	-debug_all \
	-l com.log \
	+lint=TFIPC-L #print out detailed information of unconnected ports
	-f v_list.f

simulate:
	./simv +ntb_random_seed=$(SEED) -l sim.log

dve:
	dve -full64 -vpd vcdplus.vpd &

clean:
	rm -rf csrc* simv* *.tmp *.key *.vpd *.log DVEfiles coverage *.vdb *hdrs.v core.*
