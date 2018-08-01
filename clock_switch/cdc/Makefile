DESIGN = clock_switch_ICG

cdc_setup:
	spyglass -project $(DESIGN).prj -goals "cdc/cdc_setup_check" -batch

cdc_verify:
	spyglass -project $(DESIGN).prj -goals "cdc/cdc_verify_struct" -batch

gui:
	spyglass -project $(DESIGN).prj &

clean:
	rm -rf chip_lib *.log *_results

ms:
	find ./ -name *moresimple*
