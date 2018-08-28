
	//write mode reg
	#10;
  $display("write mode reg ....\n");
	ahb_write(32'h04,32'h00);
	#10;
	//write opcode_a reg
  $display("write opcode_a reg ....\n");
	ahb_write(32'h08,32'h0000_3254);
	#10;
	//write opcode_b reg
  $display("write opcode_b reg ....\n");
	ahb_write(32'h0C,32'h0000_0000);
	#10;
	//write ctrl reg
  $display("write ctrl reg ....\n");
	ahb_write(32'h00,32'h01);
	
	#10;
	//read result reg
  $display("read result reg ....\n");
	ahb_read(32'h10,rdata);
  $display("The result is %h\n",rdata);
        
  if(rdata == 32'h00000000)
  $display("TC_and case_passed ^_^\n");
  else
  $display("TC_and case_failed *_*\n");

