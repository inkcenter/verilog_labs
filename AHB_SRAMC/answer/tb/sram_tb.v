



`timescale 1ns/1ps

module sram_sp_tb;

reg		clk;
reg    		cen;
reg   	 	wen;
reg   	 	oen;
reg [12:0] 	addr;
reg [7:0] 	data_in;		

wire [7:0]  data_out;

reg [7:0] rdata;

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
  $vcdpluson();
end
`endif

 
initial begin
        cen = 1'b1;
        oen = 1'b0;
        wen = 1'b1;
	addr = 13'b0;
        
        #120;
        sram_write(13'h1,8'h12);	
        sram_write(13'h4,8'h34);	
        sram_read(13'h1,rdata);	
        sram_read(13'h4,rdata);	
//`include  "testcase.v"

 
	#100;
	$finish;
end


sram_sp_hse_8kx8 U_sram_sp(
   .Q  (data_out),
   .CLK(clk),
   .CEN(cen),
   .WEN(wen),
   .A  (addr),
   .D  (data_in),
   .OEN(oen)
);


	
task sram_write(input [12:0] waddr,input [7:0] wdata);
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


task sram_read(input [12:0] raddr,output [7:0] rdata);
begin
	@(posedge clk);
        #0.1;
        cen = 1'b0;
        oen = 1'b0;
        wen = 1'b1;
	addr = raddr;
	@(posedge clk);
        #0.1;
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

