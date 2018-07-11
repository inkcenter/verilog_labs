RTL  = ./../rtl/mul_unsigned.v
TB   = ./../tb/mul_unsigned_tb.v

RTL_FOR = ./../rtl/mul_unsigned_for.v
TB_FOR  = ./../tb/mul_unsigned_for_tb.v

RTL_FOR4 = ./../rtl/mul_unsigned_for4.v
TB_FOR4  = ./../tb/mul_unsigned_for4_tb.v

RTL_untree = ./../rtl/mul_unsigned_untree.v
TB_untree  = ./../tb/mul_unsigned_untree_tb.v

RTL_fixed = ./../rtl/mul_fixed.v
TB_fixed  = ./../tb/mul_fixed_tb.v

RTL_pipeline = ./../rtl/mul_unsigned_pipeline.v
TB_pipeline  = ./../tb/mul_unsigned_pipeline_tb.v

TIME = ./../tb/timescale.v

run: compile simulate

run_for:
	vcs -R -sverilog -debug_all $(TIME) $(RTL_FOR) $(TB_FOR) -l run.log

run_for4:
	vcs -R -sverilog -debug_all $(TIME) $(RTL_FOR4) $(TB_FOR4) -l run.log

run_untree:
	vcs -R -sverilog -debug_all $(TIME) $(RTL_untree) $(TB_untree) -l run.log

run_fixed:
	vcs -R -sverilog -debug_all $(TIME) $(RTL_fixed) $(TB_fixed) -l run.log

run_pipeline:
	vcs -R -sverilog -debug_all $(TIME) $(RTL_pipeline) $(TB_pipeline) -l run.log

compile:
	vcs -sverilog -debug_all $(TIME) $(RTL) $(TB) -l com.log

simulate:
	./simv +ntb_random_seed=$(SEED) -l sim.log

dve:
	dve -vpd vcdplus.vpd &

clean:
	rm -rf csrc* simv* *.tmp *.key *.vpd *.log DVEfiles coverage *.vdb *hdrs.v core.*
