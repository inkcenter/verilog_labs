
module ahb_slave_clac(
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
                        
            result,
            //output signals
		        hready_resp,
		        hresp,
		        hrdata,
            ctrl,
            clac_mode,
            opcode_a,
            opcode_b
                   );
  input          hclk;
  input          hresetn;
  input          hsel;
  input          hwrite;
  input          hready;
  input [2:0]    hsize ;    
  input [2:0]    hburst;
  input [1:0]    htrans;
  input [31:0]   hwdata;
  input [7:0]    haddr;
  
  input [31:0]   result;

  output         hready_resp;
  output [1:0]   hresp;
  output [31:0]  hrdata;
  output         ctrl;
  output [1:0]   clac_mode;
  output [15:0]  opcode_a;
  output [15:0]  opcode_b;

  reg    [31:0] hrdata;

  reg hwrite_r      ;
  reg [2:0] hsize_r ;    
  reg [2:0] hburst_r;
  reg [1:0] htrans_r;
  reg [7:0] haddr_r;


  wire    ahb_write;
  wire    ahb_read;
  
  reg  enable_r;
  reg [1:0] ctrl_r;
  reg [15:0] opa_r;
  reg [15:0] opb_r;

  parameter     IDLE   = 2'b00,
                BUSY   = 2'b01,
		NONSEQ = 2'b10,
		SEQ    = 2'b11;

 
  parameter     ENABLE_ADDR = 8'h00,
                CTRL_ADDR   = 8'h04,
                OPA_ADDR    = 8'h08,
                OPB_ADDR    = 8'h0c,
                RESULT_ADDR = 8'h10;

  assign ctrl = enable_r;
  assign clac_mode = ctrl_r;
  assign opcode_a = opa_r; 
  assign opcode_b = opb_r; 

  assign hready_resp = 1'b1;
  assign hresp  = 2'b00;
  
  // generate write and read enable signal
  assign ahb_write = ((htrans_r == NONSEQ) || (htrans_r == SEQ)) && hwrite_r && hready;
  assign ahb_read =  ((htrans_r == NONSEQ) || (htrans_r == SEQ)) && (!hwrite_r) && hready;


  always @(posedge hclk or negedge hresetn )
  begin
    if(!hresetn)
    begin
      enable_r <= 1'b0;    
      ctrl_r   <= 2'b0;
      opa_r    <= 16'b0;
      opb_r    <= 16'b0;
    end
    else if(ahb_write)
    begin
      case(haddr_r)
      ENABLE_ADDR: enable_r <= hwdata[0]; 
      CTRL_ADDR  : ctrl_r   <= hwdata[1:0]; 
      OPA_ADDR   : opa_r    <= hwdata[15:0]; 
      OPB_ADDR   : opb_r    <= hwdata[15:0]; 
      endcase
    end
  end
  
  //--------------------------------------------------------
  //  Sequential portion
  //--------------------------------------------------------

  //tmp the ahb address and control signals
  always@(posedge hclk or negedge hresetn)
  begin
    if(!hresetn) 
    begin
      hwrite_r  <= 1'b0  ;
      hsize_r   <= 3'b0  ;    
      hburst_r  <= 3'b0  ;
      htrans_r  <= 2'b0  ;
      haddr_r   <= 8'b0 ;
    end
    else         
    if(hready && hsel)
    begin
      hwrite_r  <= hwrite ;
      hsize_r   <= hsize  ;    
      hburst_r  <= hburst ;
      htrans_r  <= htrans ;
      haddr_r   <= haddr  ;
    end
   else
    begin
      hwrite_r  <= 1'b0 ;
      hsize_r   <= 3'b0 ;    
      hburst_r  <= 3'b0 ;
      htrans_r  <= 2'b0 ;
    end
  end

  //assign hrdata = ahb_read ? bogus_reg : 32'h0;
  always@(*)
  begin
    if(ahb_read)
    begin
    case(haddr_r[7:0])
      ENABLE_ADDR      :  hrdata = {31'b0,enable_r}; 
      CTRL_ADDR        :  hrdata = {30'b0,ctrl_r}; 
      OPA_ADDR         :  hrdata = {16'b0,opa_r}; 
      OPB_ADDR         :  hrdata = {16'b0,opb_r}; 
      RESULT_ADDR      :  hrdata = result; 
      default          :  hrdata = 32'h0; 
    endcase
    end
    else
      hrdata = 32'b0;
  end


endmodule
