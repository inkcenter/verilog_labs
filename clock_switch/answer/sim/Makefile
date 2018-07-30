.PHONY: com sim cov clean debug

#OUTPUT = apb2apb_async
OUTPUT = gfree3
ALL_DEFINE = +define+DUMP_VPD

# Code coverage command 
CM = -cm line+cond+fsm+branch+tgl
CM_NAME = -cm_name $(OUTPUT)
CM_DIR = -cm_dir ./$(OUTPUT).vdb

# vpd file name
VPD_NAME = +vpdfile+$(OUTPUT).vpd

# Compile command 
#VCS = vcs +v2k -timescale=1ns/1ns            
VCS = vcs +v2k -override_timescale=1ns/100ps            \
      -full64 \
      -fsdb                                  \
      -debug_all   		                       \
      -sverilog                                        \
      +nospecify                                       \
      +vcs+flush+all                                   \
      $(CM)                                            \
      $(CM_NAME)                                       \
      $(CM_DIR)                                        \
      $(ALL_DEFINE) 			               \
      $(VPD_NAME)                                      \
      -o  $(OUTPUT)                                    \
      -l  compile.log 

# simulation command
SIM = ./$(OUTPUT)                \
      +ntb_random_seed_automatic \
      $(CM) $(CM_NAME) $(CM_DIR) \
      $(VPD_NAME)                \
      $(ALL_DEFINE) \
      -l $(OUTPUT).log  

# start compile
com: 
	$(VCS) -f file_list.f

# Start simulation
sim: 
	$(SIM) 

# RUN
run: com sim

# Show the coverage
cov: 
	dve -covdir *vdb &
debug:
	dve -vpd   $(OUTPUT).vpd &
ver_debug:
	verdi -f file_list.f -ssf $(OUTPUT)_test.fsdb &

# Start clean
clean: 
	rm -rf  ./csrc  *.daidir  ./csrc   *.log   *.vpd   *.vdb  simv*  *.key  *race.out* novas.* *.fsdb verdi* $(OUTPUT)
