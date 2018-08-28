
	//write mode reg
	#10;
        $display("SV----write mode reg ....\n");
	clac_ahb_if.ahb_write(32'h04,32'h01);
	#10;
	//write opcode_a reg
        opcode_a=$random();
        $display("SV----write opcode_a reg %h\n",{16'h0,opcode_a});
	clac_ahb_if.ahb_write(32'h08,{16'b0,opcode_a});
	#10;
	//write opcode_b reg
        opcode_b=$random();
        $display("SV----write opcode_b reg %h\n",{16'h0,opcode_b});
	clac_ahb_if.ahb_write(32'h0c,{16'b0,opcode_b});
	#10;
	//write ctrl reg
        $display("SV----write ctrl reg ....\n");
	clac_ahb_if.ahb_write(32'h00,32'h01);
	
	#10;
	//read result reg
        $display("SV----read result reg ....\n");
	clac_ahb_if.ahb_read(32'h10,rdata);
        $display("SV----The result is %h\n",rdata);
        
        if(rdata == {16'b0,(opcode_a | opcode_b)})
        $display("SV----TC_or case_passed ^_^\n");
        else
        $display("SV----TC_or case_failed *_*\n");

