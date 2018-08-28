



//`timescale 1ns/1ps

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
  $vcdpluson();
end
`endif

`ifdef FSDB_ON
initial begin
  $fsdbDumpfile("aaa.fsdb");
  $fsdbDumpvars();
end
`endif

`ifdef VCD_ON
initial begin
  $dumpfile("aaa.vcd");
  $dumpvars();
end
`endif

`ifdef SHM_ON
initial  begin
  $shm_open("aaa.shm");
  $shm_probe(ahb_clac_top_tb,"AC");
  $shm_close;
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
  $display("sim start....\n\n\n");	
`include "testcase.v"


 
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

