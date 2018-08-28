



`timescale 1ns/1ps

module ahb_clac_top_tb;

ahb_if clac_ahb_if();
reg [31:0] rdata;

logic [15:0] opcode_a;
logic [15:0] opcode_b;

//dump waveform 
//`ifdef VPD_ON
initial begin
  $vcdpluson(ahb_clac_top_tb);
end
//`endif

 
initial begin
#1000;	
`include  "testcase.sv"
 
	#100;
	$finish;
end



ahb_clac_top U_clac_top(
                        .hclk         (clac_ahb_if.hclk       ),
		        .hresetn      (clac_ahb_if.hresetn    ),
		        .hsel         (clac_ahb_if.hsel       ),
		        .hwrite       (clac_ahb_if.hwrite     ),
                        .hready       (clac_ahb_if.hready     ),
		        .hsize        (clac_ahb_if.hsize      ),
		        .htrans       (clac_ahb_if.htrans     ),
		        .hburst       (clac_ahb_if.hburst     ),
		        .hwdata       (clac_ahb_if.hwdata     ),
		        .haddr        (clac_ahb_if.haddr      ),
		        .hready_resp  (clac_ahb_if.hready_resp),
		        .hresp        (clac_ahb_if.hresp      ),
		        .hrdata       (clac_ahb_if.hrdata     )
                   );

endmodule

