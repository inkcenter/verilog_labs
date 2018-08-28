
TC=

COV_OPTION = -cm line+cond+fsm+tgl+branch
COV_OPTION += -cm_dir ${TC}_cov
VPD_OPTION = -debug_pp
VPD_OPTION += +define+VPD_ON 
#TIMING_OPTION = +nospecify
TIMING_OPTION = +notimingcheck
#TIMING_OPTION = 

copy_case:
	cp -rf ../tc/${TC}.v  testcase.v


run_rtl_cov:
	vcs -f model.list -f rtl.list -f tb.list -timescale=1ns/1ps ${COV_OPTION} -v2005 +v2k ${VPD_OPTION} ${TIMING_OPTION} -Mupdate -R -l sim.log

run_rtl:
	vcs -f model.list -f rtl.list -f tb.list -timescale=1ns/1ps -v2005 +v2k ${VPD_OPTION} ${TIMING_OPTION} -Mupdate -R -l sim.log

clean:
	rm -rf *simv *.vpd *.simdb *.rc *csrc *.daidir *.log *DVEfiles *key

clean_run:clean run_rtl

help:
	@echo ========================================================================================================= 
	@echo "                                                                                                       "	
	@echo "--------USAGE:make clean.run                                                                    -------"
	@echo "                                                                                                       "
	@echo "------------------------------------------DEBUG TARGETS------------------------------------------------"
