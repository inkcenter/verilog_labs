



`timescale 1ns/1ps

module sram_core_tb;

reg		clk;
reg		reset_n;
reg    		cen;
reg   	 	wen;
reg   	 	oen;
reg [12:0] 	addr;
reg [31:0] 	data_in;		

wire [31:0]  data_out;

reg [31:0] rdata;

// clock generator
initial 
begin
	clk = 0;
	forever
	begin
		#10 clk = ~clk;
	end
end

//dump waveform 
`ifdef VPD_ON
initial begin
  $vcdpluson(2,sram_core_tb.U_sram_core);
end
`endif


initial begin
        reset_n =1'b0;
        #34;
        reset_n =1'b1;
end

// just for debug
initial begin
    #164011;
    force sram_core_tb.U_sram_core.U_sram_bist0.sram_oen = 1;
    #20;
    release sram_core_tb.U_sram_core.U_sram_bist0.sram_oen ;
end


 
initial begin
        cen = 1'b1;
        oen = 1'b0;
        wen = 1'b1;
	addr = 13'b0;
	data_in = 32'b0;
        
        #120;
//        sram_write(13'h1,8'h12);	
//        sram_write(13'h4,8'h34);	
//        sram_read(13'h1,rdata);	
//        sram_read(13'h4,rdata);	
//`include  "testcase.v"

 
	wait(sram_core_tb.U_sram_core.bist_done);
	$display("Sim finish\n\n");
        #100;
	$finish;
end

sram_core U_sram_core(
                  .hclk          (clk),
                  .sram_clk      (!clk),
                  .hresetn       (reset_n),
                  .sram_wen      (wen),
                  .sram_addr     (addr),
                  .sram_wdata_in (data_in),
                  .bank0_csn     (4'b0000),
                  .bank1_csn     (4'b1111),
                  .bist_en       (1'b1),
                  .dft_en        (1'b0),
                  .sram_q0       (),
                  .sram_q1       (),
                  .sram_q2       (),
                  .sram_q3       (),
                  .sram_q4       (),
                  .sram_q5       (),
                  .sram_q6       (),
                  .sram_q7       (),
                  .bist_done     (),
                  .bist_fail     ()
                 );


	
task sram_write(input [12:0] waddr,input [31:0] wdata);
begin
	@(posedge clk);
        #0.1;
        cen = 1'b0;
        oen = 1'b0;
        wen = 1'b0;
	addr = waddr;
	data_in = wdata;
	@(posedge clk);
        #0.1;
        cen = 1'b1;
        oen = 1'b0;
        wen = 1'b0;
	addr = 13'b0;
	data_in = 8'b0;
	@(posedge clk);
	@(posedge clk);
end
endtask


task sram_read(input [12:0] raddr,output [31:0] rdata);
begin
	@(posedge clk);
        #1;
        cen = 1'b0;
        oen = 1'b0;
        wen = 1'b1;
	addr = raddr;
	@(posedge clk);
        #1;
        cen = 1'b1;
        oen = 1'b0;
        wen = 1'b1;
	addr = 13'b0;
	@(posedge clk);
	rdata = data_out;
	@(posedge clk);
end
endtask


endmodule

