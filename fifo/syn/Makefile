clean:
	rm -rf *.log *.svf *.pvl *.syn *.mr *.v *.sdf *Synth *.ddc WORK

run:
	dc_shell -gui -f syn.tcl | tee -i syn.log

run_mcp:
	dc_shell -gui -f syn_mcp.tcl | tee -i syn_mcp.log

run_mcp_top:
	dc_shell -gui -f syn_mcp_top.tcl | tee -i syn_mcp_top.log
