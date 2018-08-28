
module ahb_slave_if(
                    //input signals
                    hclk       ,
		    hresetn    ,
		    hsel       ,
		    hwrite     ,
                    hready     ,
		    hsize      ,
		    htrans     ,
		    hburst     ,
		    hwdata     ,
		    haddr      ,

                    sram_q0    ,
                    sram_q1    ,
                    sram_q2    ,
                    sram_q3    ,
                    sram_q4    ,
                    sram_q5    ,
                    sram_q6    ,
                    sram_q7    ,

                    //output signals
		    hready_resp,
		    hresp      ,
		    hrdata     ,

		    sram_w_en    ,
                    sram_addr_out,
                    sram_wdata   ,
                    bank0_csn    ,
                    bank1_csn    
                   );
  //--------------------------------------------
  //              List of AHB signals
  //--------------------------------------------
  //Signals used during normal operation
  input hclk;
  input hresetn;

  //----------------------------------------------------
  //Signals from AHB bus used during normal operation
  //----------------------------------------------------
  input hsel;
  input hwrite;
  input hready;
  input [2:0] hsize ;    
  input [2:0] hburst;
  input [1:0] htrans;
  input [31:0] hwdata;
  input [31:0] haddr;

  //---------------------------------------------------
  //Signals from sram core data output(read srams)
  //---------------------------------------------------
  input [7:0] sram_q0;
  input [7:0] sram_q1;
  input [7:0] sram_q2;
  input [7:0] sram_q3;
  input [7:0] sram_q4;
  input [7:0] sram_q5;
  input [7:0] sram_q6;
  input [7:0] sram_q7;

  //---------------------------------------------------
  //Signals to AHB bus used during normal operation
  //---------------------------------------------------
  output hready_resp;
  output [1:0] hresp;
  output [31:0] hrdata;

  //---------------------------------------------------
  //sram read or write enable signals
  //When "sram_w_en" is low, it means write sram; and 
  //high, it means read sram. 
  //---------------------------------------------------
  output sram_w_en;

  //---------------------------------------------------
  //choose the right srams when bank is confirmed:
  //bank_csn allows the four bytes in the 32-bit width
  //to be written independently.
  //---------------------------------------------------
  output [3:0] bank0_csn; 
  output [3:0] bank1_csn; 

  //----------------------------------------------------
  //Signals to sram core in noraml operation, it contains
  //sram address and data writing into sram.
  //----------------------------------------------------
  output [12:0] sram_addr_out;
  output [31:0] sram_wdata;

  //-------------------------------------------------------
  //internal registers used for temp the input ahb signals
  //-------------------------------------------------------
  //temperate all the AHB input signals
  reg hwrite_r      ;
  reg [2:0] hsize_r ;    
  reg [2:0] hburst_r;
  reg [1:0] htrans_r;
  reg [31:0] haddr_r;

  reg [3:0] sram_csn; 
  
  //------------------------------------------------------
  //Internal signals
  //------------------------------------------------------
  //"haddr_sel " and "hsize_sel" used to generate banks of
  //sram: "bank0_sel" and "bank1_sel".
  wire [1:0] haddr_sel;
  wire [1:0] hsize_sel;
  wire bank_sel;

  wire sram_csn_en;  //sram chip select enable

  wire sram_write; //sram write enable signal from AHB bus
  wire sram_read;  //sram read enable signal from AHB bus
  wire [15:0] sram_addr; //sram address from AHB bus
  wire [31:0] sram_data_out;//data read from sram and send to AHB bus

  //---------------------------------------------------
  // transfer type signal encoding
  //----------------------------------------------------
  parameter     IDLE   = 2'b00,
                BUSY   = 2'b01,
		NONSEQ = 2'b10,
		SEQ    = 2'b11;

  //---------------------------------------------------------
  //        Main Code
  //---------------------------------------------------------


  //---------------------------------------------------------
  //  Combinatorial portion
  //---------------------------------------------------------

  //assign the response and read data of the ahb slave 
  //In order to implement the sram function-writing or reading
  //in one cycle, the value of hready_resp is always "1". 
  assign hready_resp = 1'b1;
  assign hresp  = 2'b00;
  
  //---------------------------------------------------------
  //sram data output to AHB bus
  //---------------------------------------------------------
  assign   hrdata = sram_data_out;

  //Choose the right data output of the two banks(bank0, bank1) according
  //to the value of bank_sel. If bank_sel = 1'b1, bank0 sleceted, or 
  //bank1 selected.
  assign  sram_data_out = (bank_sel) ?  {sram_q3, sram_q2, sram_q1, sram_q0} :
                                        {sram_q7, sram_q6, sram_q5, sram_q4} ;

  //Generate sram write and read enable signals.
  assign sram_write = ((htrans_r == NONSEQ) || (htrans_r == SEQ)) && hwrite_r;
  assign sram_read =  ((htrans_r == NONSEQ) || (htrans_r == SEQ)) && (!hwrite_r);
  assign sram_w_en = !sram_write;

  //generate sram address
  assign sram_addr = haddr_r [15:0];
  assign sram_addr_out = sram_addr[14:2];

  //Generate bank select signals by the value of sram_addr[15].
  //Each bank(32kx32) comprises of four sram block(8kx8), and
  //the width of the address of the bank is 15 bits(14~0), so 
  //the sram_addr[15] is the minimun of the next bank. If its 
  //value is "1", it means the next bank is selcted. 
  assign sram_csn_en = (sram_write || sram_read);
  assign bank_sel = (sram_csn_en && (sram_addr[15] == 1'b0)) ? 1'b1 : 1'b0;

  assign bank0_csn = (sram_csn_en && (sram_addr[15] == 1'b0)) ? sram_csn : 4'b1111;
  assign bank1_csn = (sram_csn_en && (sram_addr[15] == 1'b1)) ? sram_csn : 4'b1111;

  //signals used to generating sram chip select signal in one bank.
  assign haddr_sel = sram_addr[1:0];
  assign hsize_sel = hsize_r [1:0];

  //-------------------------------------------------------
  //data from ahb writing into sram
  //-------------------------------------------------------
  assign sram_wdata = hwdata;
  
  //-------------------------------------------------------
  //Generate the sram chip selecting signals in one bank.
  //The resluts show the AHB bus write or read how many data
  //once a time: byte, halfword or word.
  //---------------------------------------------------------
  always@(hsize_sel or haddr_sel) 
  begin
    if(hsize_sel == 2'b10)
      sram_csn = 4'b0;
    else
    if(hsize_sel == 2'b01)
    begin
      if(haddr_sel[1] == 1'b0)
        sram_csn = 4'b1100;
      else
        sram_csn = 4'b0011;
    end
    else
    if(hsize_sel == 2'b00)
    begin
      case(haddr_sel)
        2'b00 : sram_csn = 4'b1110;
        2'b01 : sram_csn = 4'b1101;
        2'b10 : sram_csn = 4'b1011;
        2'b11 : sram_csn = 4'b0111;
        default : sram_csn = 4'b1111;
      endcase
    end
    else
      sram_csn = 4'b1111;
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
      haddr_r   <= 32'b0 ;
    end
    else         
    if(hsel && hready)   //added by fuxsh, 2010-10-14
    begin
      hwrite_r  <= hwrite ;
      hsize_r   <= hsize  ;  
      hburst_r  <= hburst ;
      htrans_r  <= htrans ;
      haddr_r   <= haddr  ;
    end
    else                   //added by fuxsh, 2010-9-30
    begin
      hwrite_r  <= 1'b0  ;
      hsize_r   <= 3'b0  ;  
      hburst_r  <= 3'b0  ;
      htrans_r  <= 2'b0  ;
      haddr_r   <= 32'b0 ;
    end
  end

endmodule
