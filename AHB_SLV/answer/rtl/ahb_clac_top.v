
module ahb_clac_top(
                        //input signals
                        hclk,
		        hresetn,
		        hsel,
		        hwrite,
                        hready,
		        hsize,
		        htrans,
		        hburst,
		        hwdata,
		        haddr,
                        
                        //output signals
		        hready_resp,
		        hresp,
		        hrdata
                   );
  input hclk;
  input hresetn;
  input hsel;
  input hwrite;
  input hready;
  input [2:0] hsize ;    
  input [2:0] hburst;
  input [1:0] htrans;
  input [31:0] hwdata;
  input [7:0] haddr;
  

  output hready_resp;
  output [1:0] hresp;
  output [31:0] hrdata;

  wire  ctrl;
  wire  [1:0] clac_mode;
  wire  [15:0] opcode_a;
  wire  [15:0] opcode_b;
  wire  [31:0] result;



ahb_slave_clac U_slave_if(
                        .hclk        (hclk        ),
		        .hresetn     (hresetn     ),
		        .hsel        (hsel        ),
		        .hwrite      (hwrite      ),
                        .hready      (hready      ),
		        .hsize       (hsize       ),
		        .htrans      (htrans      ),
		        .hburst      (hburst      ),
		        .hwdata      (hwdata      ),
		        .haddr       (haddr       ),
                        .result      (result      ),
		        .hready_resp (hready_resp ),
		        .hresp       (hresp       ),
		        .hrdata      (hrdata      ),
                        .ctrl        (ctrl        ),
                        .clac_mode   (clac_mode   ),
                        .opcode_a    (opcode_a    ),
                        .opcode_b    (opcode_b    )
                       ); 


clac U_clac(
          .ctrl      (ctrl     ),
          .clac_mode (clac_mode),
          .opcode_a  (opcode_a ),
          .opcode_b  (opcode_b ),
          .result    (result   )
         );

endmodule
