module sram_core(
                  //input signals
                  hclk,
                  sram_clk,
                  hresetn,
                  sram_wen,
                  sram_addr,
                  sram_wdata_in,
                  bank0_csn,
                  bank1_csn,
                  bist_en,
                  dft_en,
        
                  //output signals
                  sram_q0,
                  sram_q1,
                  sram_q2,
                  sram_q3,
                  sram_q4,
                  sram_q5,
                  sram_q6,
                  sram_q7,
                  
                  bist_done,
                  bist_fail
                 );
  //Signals used during normal opetation
  input hclk;
  input sram_clk;
  input hresetn;

  //sram write or read enable
  //active high, read sram; 
  //active low, write sram.
  input sram_wen;

  //srma address used when read or write sram
  input [12:0] sram_addr;

  //data write into sram when "sram_wen_in" active low 
  input [31:0] sram_wdata_in;

  //---------------------------------------------------
  //choose the right srams when bank is confirmed:
  //bank_csn allows the four bytes in the 32-bit wide
  //to be written independently.
  //---------------------------------------------------
  input [3:0] bank0_csn;
  input [3:0] bank1_csn;

  //BIST test mode
  input bist_en;
 
  //DFT test mode
  input dft_en;

  //------------------------------------------------
  //Every sram  data output.
  //------------------------------------------------
  output [7:0] sram_q0;
  output [7:0] sram_q1;
  output [7:0] sram_q2;
  output [7:0] sram_q3;
  output [7:0] sram_q4;
  output [7:0] sram_q5;
  output [7:0] sram_q6;
  output [7:0] sram_q7;

  //When "bist_done" is high, it shows BIST test is over.
  output bist_done;

  //"bist_fail" shows the results of each sram funtions.
  output [7:0] bist_fail;
 
  //----------------------------------------------------
  //Every sram bist's work state and results output.
  //----------------------------------------------------
  wire bist_done0;
  wire bist_fail0;
  wire bist_done1;
  wire bist_fail1;
  wire bist_done2;
  wire bist_fail2;
  wire bist_done3;
  wire bist_fail3;
  wire bist_done4;
  wire bist_fail4;
  wire bist_done5;
  wire bist_fail5;
  wire bist_done6;
  wire bist_fail6;
  wire bist_done7;
  wire bist_fail7;

  wire bank0_bistdone;
  wire bank1_bistdone;

  wire [3:0] bank0_bistfail;
  wire [3:0] bank1_bistfail;

  //bist finishing state of bank0
  assign bank0_bistdone = (bist_done3 && bist_done2) && (bist_done1 && bist_done0);

  //bist results of bank0
  assign bank0_bistfail = {bist_fail3,bist_fail2,bist_fail1,bist_fail0};

  //bist finishing state of bank1
  assign bank1_bistdone = (bist_done7 && bist_done6) && (bist_done5 && bist_done4);

  //bist results of bank1
  assign bank1_bistfail = {bist_fail7,bist_fail6,bist_fail5,bist_fail4};

  //--------------------------------------------------------------------------
  //the 8 srams results of BIST test and the finishing state
  //--------------------------------------------------------------------------
  assign bist_done = bank0_bistdone && bank1_bistdone;
  assign bist_fail = {bank1_bistfail,bank0_bistfail} ;

  //-------------------------------------------------------------------------
  //Instance 8 srams and each provides with BIST and DFT functions. 
  //Bank0 comprises of sram0~sram3, and bank1 comprises of sram4~sram7. 
  //In each bank, the sram control signals broadcast to each sram, and data
  //written per byte into each sram in little-endian style.
  //-------------------------------------------------------------------------

  sram_bist U_sram_bist0(
                        .hclk             (hclk),
                        .sram_clk         (sram_clk),
                        .sram_rst_n       (hresetn),
                        .sram_csn_in      (bank0_csn[0]),
                        .sram_wen_in      (sram_wen),
                        .sram_addr_in     (sram_addr),
                        .sram_wdata_in    (sram_wdata_in[7:0]),
                        .bist_en          (bist_en),
		        .dft_en           (dft_en),
                                   
                        .sram_data_out    (sram_q0),
                        .bist_done        (bist_done0),
                        .bist_fail        (bist_fail0)  
                       );

  sram_bist U_sram_bist1(
                        .hclk             (hclk),
                        .sram_clk         (sram_clk),
                        .sram_rst_n       (hresetn),
                        .sram_csn_in      (bank0_csn[1]),
                        .sram_wen_in      (sram_wen),
                        .sram_addr_in     (sram_addr),
                        .sram_wdata_in    (sram_wdata_in[15:8]),
                        .bist_en          (bist_en),
		        .dft_en           (dft_en),
                                   
                        .sram_data_out    (sram_q1),
                        .bist_done        (bist_done1),
                        .bist_fail        (bist_fail1)  
                       );

  sram_bist U_sram_bist2(
                        .hclk             (hclk),
                        .sram_clk         (sram_clk),
                        .sram_rst_n       (hresetn),
                        .sram_csn_in      (bank0_csn[2]),
                        .sram_wen_in      (sram_wen),
                        .sram_addr_in     (sram_addr),
                        .sram_wdata_in    (sram_wdata_in[23:16]),
                        .bist_en          (bist_en),
		        .dft_en           (dft_en),
                                   
                        .sram_data_out    (sram_q2),
                        .bist_done        (bist_done2),
                        .bist_fail        (bist_fail2)  
                       );

  sram_bist U_sram_bist3(
                        .hclk             (hclk),
                        .sram_clk         (sram_clk),
                        .sram_rst_n       (hresetn),
                        .sram_csn_in      (bank0_csn[3]),
                        .sram_wen_in      (sram_wen),
                        .sram_addr_in     (sram_addr),
                        .sram_wdata_in    (sram_wdata_in[31:24]),
                        .bist_en          (bist_en),
		        .dft_en           (dft_en),
                                   
                        .sram_data_out    (sram_q3),
                        .bist_done        (bist_done3),
                        .bist_fail        (bist_fail3)  
                       );

  sram_bist U_sram_bist4(
                        .hclk             (hclk),
                        .sram_clk         (sram_clk),
                        .sram_rst_n       (hresetn),
                        .sram_csn_in      (bank1_csn[0]),
                        .sram_wen_in      (sram_wen),
                        .sram_addr_in     (sram_addr),
                        .sram_wdata_in    (sram_wdata_in[7:0]),
                        .bist_en          (bist_en),
		        .dft_en           (dft_en),
                                   
                        .sram_data_out    (sram_q4),
                        .bist_done        (bist_done4),
                        .bist_fail        (bist_fail4)  
                       );

  sram_bist U_sram_bist5(
                        .hclk             (hclk),
                        .sram_clk         (sram_clk),
                        .sram_rst_n       (hresetn),
                        .sram_csn_in      (bank1_csn[1]),
                        .sram_wen_in      (sram_wen),
                        .sram_addr_in     (sram_addr),
                        .sram_wdata_in    (sram_wdata_in[15:8]),
                        .bist_en          (bist_en),
		        .dft_en           (dft_en),
                                   
                        .sram_data_out    (sram_q5),
                        .bist_done        (bist_done5),
                        .bist_fail        (bist_fail5)  
                       );

  sram_bist U_sram_bist6(
                        .hclk             (hclk),
                        .sram_clk         (sram_clk),
                        .sram_rst_n       (hresetn),
                        .sram_csn_in      (bank1_csn[2]),
                        .sram_wen_in      (sram_wen),
                        .sram_addr_in     (sram_addr),
                        .sram_wdata_in    (sram_wdata_in[23:16]),
                        .bist_en          (bist_en),
		        .dft_en           (dft_en),
                                   
                        .sram_data_out    (sram_q6),
                        .bist_done        (bist_done6),
                        .bist_fail        (bist_fail6)  
                       );
		  
  sram_bist U_sram_bist7(
                        .hclk             (hclk),
                        .sram_clk         (sram_clk),
                        .sram_rst_n       (hresetn),
                        .sram_csn_in      (bank1_csn[3]),
                        .sram_wen_in      (sram_wen),
                        .sram_addr_in     (sram_addr),
                        .sram_wdata_in    (sram_wdata_in[31:24]),
                        .bist_en          (bist_en),
		        .dft_en           (dft_en),
                                   
                        .sram_data_out    (sram_q7),
                        .bist_done        (bist_done7),
                        .bist_fail        (bist_fail7)  
                       );

endmodule
