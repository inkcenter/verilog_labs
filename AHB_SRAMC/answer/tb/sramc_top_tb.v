



`timescale 1ns/1ps

module sramc_top_tb;

reg		hclk;
reg		sram_clk;
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
	hwdata = 0;
	#200;
	hresetn = 1;
	
    //    ahb_write_32(32'h0,32'h11223344); 
    //    ahb_write_32(32'h4,32'h55667788); 
    //    ahb_write_32(32'h8,32'h99aabbcc); 
    //    ahb_read_32(32'h8,rdata); 
    //    ahb_read_32(32'h4,rdata); 
    //    ahb_read_32(32'h0,rdata); 
  wait(U_sram_top.bist_done); 
  $display("**************bist done*************\n");
	#100;
	$finish;
end

//initial
//begin
//  #672591;
//  force U_sram_top.U_sram_core.U_sram_bist0.U_bist.ram_read_out = 8'hab;
//  #60;
//  release U_sram_top.U_sram_core.U_sram_bist0.U_bist.ram_read_out ;
//end


sramc_top  U_sram_top(
    .hclk           (hclk       ),
    .sram_clk       (hclk),
		.hresetn        (hresetn    ),
		.hsel           (hsel       ),
		.hwrite         (hwrite     ),
    .hready         (hready     ),
		.hsize          (hsize      ),
		.htrans         (htrans     ),
		.hburst         (hburst     ),
		.hwdata         (hwdata     ),
		.haddr          (haddr      ),
		.dft_en         (1'b0),
		.bist_en        (1'b1),
		.hready_resp    (hready_resp),
		.hresp          (hresp      ),
		.hrdata         (hrdata     ),
		.bist_done      (),
		.bist_fail      ()
               );

	
task ahb_write_32(input [31:0] addr,input [31:0] wdata);
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

task ahb_read_32(input [31:0] addr,output [31:0] rdata);
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

