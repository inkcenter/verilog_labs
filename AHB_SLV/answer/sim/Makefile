TC=tc_and

COV_OPTION = -cm line+cond+fsm+tgl+branch
COV_OPTION += -cm_dir ${TC}_cov
#COV_OPTION =

VERDI_OPTION = /qixin/eda/synopsys/verdi/2014.03/share/PLI/VCS/LINUX

copy_case:
	cp -rf ../tc/${TC}.v testcase.v

run_rtl_verdi:
	vcs -f rtl.list -f tb.list +v2k -timescale=1ns/1ps +define+FSDB_ON -debug_pp -P ${VERDI_OPTION}/novas.tab ${VERDI_OPTION}/pli.a +memcbk  ${COV_OPTION} -Mupdate -R -l sim.log

run_rtl_vpd:
	vcs -f rtl.list -f tb.list +v2k -timescale=1ns/1ps +define+VPD_ON -debug_pp  +memcbk  ${COV_OPTION} -Mupdate -R -l sim.log

run_rtl:
	vcs -f rtl.list -f tb.list +v2k -timescale=1ns/1ps  -debug_pp  +memcbk  ${COV_OPTION} -Mupdate -R -l sim.log

clean:
	rm -rf csrc simv.daidir ucli.key vcdplus.vpd simv ccc *.vdb DVEfiles *.log

merge:
	urg -dbname aaa -dir *.vdb

clean_run:clean copy_case run_rtl
