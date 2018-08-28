
//interface ahb_if(input logic hclk, input logic hresetn );
interface ahb_if();

logic           hclk;
logic           hresetn;
logic     	hsel;
logic     	hwrite;
logic 		hready;
logic  [2:0]  	hsize ;    
logic  [2:0]  	hburst;
logic  [1:0]  	htrans;
logic  [31:0] 	hwdata;
logic  [31:0] 	haddr;		

logic          hready_resp;
logic  [1:0]   hresp;
logic  [31:0]  hrdata;


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
	

 
end
	
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

endinterface

