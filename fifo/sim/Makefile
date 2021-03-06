.PHONY: run com sim dve clean

DESIGN = fifo
FILE = v_list.f
ALL_DEFINE = +define+DUMP_VPD
# Code coverage command 
CM = -cm line+cond+fsm+branch+tgl
CM_NAME = -cm_name $(DESIGN)
CM_DIR = -cm_dir ./$(DESIGN).vdb
# VPD file name
VPD_NAME = +vpdfile+$(DESIGN).vpd
# Compile command
VCS = vcs +v2k -override_timescale=1ns/100ps           \
      -full64                                          \
			-fsdb                                            \
      -debug_all   		                                 \
      -sverilog                                        \
      +nospecify                                       \
      +vcs+flush+all                                   \
      $(CM)                                            \
      $(CM_NAME)                                       \
      $(CM_DIR)                                        \
      $(ALL_DEFINE) 			                             \
      $(VPD_NAME)                                      \
      -o  $(DESIGN)                                    \
      -l  compile.log
# Simulation command
SIM = ./$(DESIGN)                \
      +ntb_random_seed_automatic \
      $(CM) $(CM_NAME) $(CM_DIR) \
      $(VPD_NAME)                \
      $(ALL_DEFINE)              \
      -l $(DESIGN).log

run: com sim

com:
	$(VCS) -f $(FILE)

sim:
	$(SIM)

#run_hier:
#	vcs -full64 -R -sverilog -debug_all +lint=TFIPC-L -f v_top.f -l run_hier.log

dve:
	dve -full64 -vpd vcdplus.vpd &

cov: 
	dve -full64 -covdir *vdb &

debug:
	verdi -f v_list.f -ssf $(DESIGN).fsdb &

clean:
	rm -rf verdiLog novas.* *.fsdb csrc* simv* *.daidir *.tmp *.key *.vpd *.vdb *.log DVEfiles coverage *.vdb *hdrs.v core.* $(DESIGN)
