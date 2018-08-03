.PHONY: run compile simulate dve clean
#########################################
#RTL_ori  = ./../rtl/clock_switch.v
#TB_ori   = ./../tb/clock_switch_tb.v
#TIME = ./../tb/timescale.v

#RTL_hier = ./../rtl/clock_switch_hier.v
#TB_hier  = ./../tb/clock_switch_hier_tb.v
#########################################
DESIGN = clock_switch_ICG
FILE = v_list.f
ALL_DEFINE = +define+DUMP_VPD
# Code coverage command 
CM = -cm line+cond+fsm+branch+tgl
CM_NAME = -cm_name $(DESIGN)
CM_DIR = -cm_dir ./$(DESIGN).vdb
# VPD file name
VPD_NAME = +vpdfile+$(DESIGN).vpd
# Compile command
# -fsdb
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

run: compile simulate

compile:
	$(VCS) -f $(FILE)

simulate:
	$(SIM)

dve:
	dve -full64 -vpd $(DESIGN).vpd &

cov: 
	dve -full64 -covdir *vdb &

debug:
	verdi -f v_list.f -ssf $(DESIGN).fsdb &
#run_hier:
#	vcs -R -sverilog -debug_all $(TIME) $(RTL_hier) $(TB_hier) -l run.log
#compile:
#	vcs -sverilog -debug_all $(TIME) $(RTL_ori) $(TB_ori) -l com.log
#simulate:
#	./simv +ntb_random_seed=$(SEED) -l sim.log
clean:
	rm -rf verdiLog novas.* *.fsdb csrc* simv* *.daidir *.tmp *.key *.vpd *.vdb *.log DVEfiles coverage *.vdb *hdrs.v core.* $(DESIGN)
