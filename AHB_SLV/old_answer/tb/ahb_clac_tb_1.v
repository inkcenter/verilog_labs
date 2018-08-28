



`timescale 1ns/1ps

module ahb_clac_top_tb;

reg		hclk;
reg    		hresetn;
reg    		hsel;
reg   	 	hwrite;
reg		hready;
reg [2:0]  	hsize ;    
reg [2:0]  	hburst;
reg [1:0]  	htrans;
reg [31:0] 	hwdata;
reg [31:0] 	haddr;		

wire         hready_resp;
wire [1:0]   hresp;
wire [31:0]  hrdata;

reg [31:0] rdata;

// clock generator
initial 
begin
	hclk = 0;
	forever
	begin
		#10 hclk = ~hclk;
	end
end

//dump waveform 
`ifdef VPD_ON
initial begin
  $vcdpluson(ahb_clac_top_tb.U_clac_top.U_clac);
end
`endif

parameter     IDLE   = 2'b00,
              BUSY   = 2'b01,
	      NONSEQ = 2'b10,
	      SEQ    = 2'b11;
 
initial begin
	hresetn = 0;
	htrans = IDLE;
	hsize = 3'b00;
	hburst=3'b00;
	hwrite = 0;
	hsel = 0;
	hready = 0;
	haddr = 0;
	#200;
	hresetn = 1;
	

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


 
	#100;
	$finish;
end



ahb_clac_top U_clac_top(
                        .hclk         (hclk       ),
		        .hresetn      (hresetn    ),
		        .hsel         (hsel       ),
		        .hwrite       (hwrite     ),
                        .hready       (hready     ),
		        .hsize        (hsize      ),
		        .htrans       (htrans     ),
		        .hburst       (hburst     ),
		        .hwdata       (hwdata     ),
		        .haddr        (haddr      ),
		        .hready_resp  (hready_resp),
		        .hresp        (hresp      ),
		        .hrdata       (hrdata     )
                   );

	
task ahb_write(input [31:0] addr,input [31:0] wdata);
begin
	@(posedge hclk);
        #1;
	hsize  = 3'b10;
        htrans = NONSEQ;
        hwrite = 1;
	hsel = 1;
	hready = 1;
	haddr = addr;
	@(posedge hclk);
        #1;
	hsize  = 2'b00;
        htrans = IDLE;
        hwrite = 0;
	hsel = 0;
	hwdata = wdata;
	@(posedge hclk);
        #1;
	haddr = 32'b0;
	@(posedge hclk);
end
endtask

task ahb_read(input [31:0] addr,output [31:0] rdata);
begin
	@(posedge hclk);
        #1;
	haddr = addr;
	hsize  = 2'b10;
        htrans = NONSEQ;
        hwrite = 0;
	hsel = 1;
	@(posedge hclk);
        #1;
	hsize  = 2'b00;
        htrans = IDLE;
        hwrite = 0;
	hsel = 0;
	@(posedge hclk);
        rdata = hrdata; 
	haddr = 32'b0;
	@(posedge hclk);
end
endtask

endmodule

