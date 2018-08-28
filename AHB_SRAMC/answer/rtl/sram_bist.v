//****************************************************************************//
//-------------------------------------------------------------------------//
//  File name : sram_bist.v                                                   //
//-------------------------------------------------------------------------//
//-------------------------------------------------------------------------//
//  Version   : 0.1                                                           //
//  Description : 8kx8 sram which instance a bist module and dft.             //
//  Function    : Memory on the chip for recoding data, and it provides       //
//                with BIST and DFT functions.                                //
//----------------------------------------------------------------------------//
//  Version     :                                                             // 
//  Modified by :                                                             // 
//-------------------------------------------------------------------------//
//  Description :                                                             //
//----------------------------------------------------------------------------//
//  Modify      : Modify the clk, when BIST or DFT not work,		      //
//		  the BIST logic has no clock.				      //
//-------------------------------------------------------------------------//
//-------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//  Modify      : Modify the control signal of the MUX in BIST		      //
//		: from "bist_en" into "bist_en & dft_en".		      //
//-------------------------------------------------------------------------//
//-------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

module sram_bist(
                 //input signals
                 hclk,
                 sram_clk,
                 sram_rst_n,
                 sram_csn_in,
                 sram_wen_in,
                 sram_addr_in,
                 sram_wdata_in,
                 bist_en,
		 dft_en,
        
                 //output signals
                 sram_data_out, 
                 bist_done,
                 bist_fail 
                );
  //Signals used during normal operation
  input hclk;
  input sram_clk;
  input sram_rst_n;
  
  //chip select enable 
  input sram_csn_in;

  //sram write or read enable
  //active high, read sram; 
  //active low, write sram.
  input sram_wen_in;
  
  //srma address used when read or write sram
  input [12:0] sram_addr_in;

  //data write into sram when "sram_wen_in" active low 
  input [7:0] sram_wdata_in;

  //BIST test mode
  input bist_en;

  //DFT test mode
  input dft_en;
                              
  //When "bist_done" is high, it shows BIST test is over.
  output bist_done;
  //"bist_fail" shows the results of each sram funtions.
  output bist_fail;
  
  //data output from sram when "sram_wen_in" active high
  output [7:0] sram_data_out;

  //----------------------------------------------------
  //Internal signals connected the sram with bist module 
  //when "bist_en" active high.
  //----------------------------------------------------
  wire sram_csn;
  wire sram_wen;
  wire sram_oen;
  wire [12:0] sram_a;
  wire [7:0] sram_d;
  wire [7:0] data_out;

  //Sram output data when "dft_en" active high.
  wire [7:0] dft_data;
  reg [7:0] dft_data_r;
 
  wire [12:0] sram_addr;
  wire [7:0] sram_wdata;

  //-------------------------------------------------------------------------//
  //clock for bist logic, when bist is not work, clock should be 0.
  wire bist_clk;
  wire bist_clk_sel;

  genvar                  K;
  
  //block sram input when cs is diable for low power design yy 20101020
  assign sram_addr = sram_csn_in ? 0 : sram_addr_in;
  assign sram_wdata = sram_csn_in ? 0 : sram_wdata_in;

  //dft test result
  assign dft_data = (sram_d ^ sram_a[7:0]) ^ {sram_csn, sram_wen, sram_oen, sram_a[12:8]}; 

  always @(posedge hclk or negedge sram_rst_n) begin
    if(!sram_rst_n)
      dft_data_r <= 0;
    else if(dft_en)
      dft_data_r <= dft_data;
  end

  //sram data output
  assign sram_data_out = dft_en ? dft_data_r : data_out;

  //----------------------------------
  //-------------------------------------------------------------------------//
  //----------------------------------
  //generate for(K = 0; K < 8; K = K+1 )
  //begin :hold
  //  HOLDX1 holdQ (.Y(data_out[K]));
  //  //BHDBWP7T holdQ (.Z(data_out[K]));
  //end endgenerate

  //---------------------------------
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //clock for bist logic, when bist is not work, clock should be 0.
  //---------------------------------
  OR2X2 U_bist_clk_sel_or (.A(bist_en), .B(dft_en), .Y(bist_clk_sel));	//MUX sel signal  
  MX2X2 U_bist_clk_mux (.A(1'b0), .B(hclk), .S0(bist_clk_sel), .Y(bist_clk));

  //OR2D2BWP7T U_bist_clk_sel_or (.A1(bist_en), .A2(dft_en), .Z(bist_clk_sel));	//MUX sel signal  
  //CKMUX2D2BWP7T U_bist_clk_mux (.I0(1'b0), .I1(hclk), .S(bist_clk_sel), .Z(bist_clk));

  //-----------------------------------------------------
  // One sram with BIST and DFT function
  //-----------------------------------------------------

sram_sp_hse_8kx8 U_sram(
                        .Q      (data_out),
                        .CLK    (sram_clk),
                        .CEN    (sram_csn),
                        .WEN    (sram_wen),
                        .A      (sram_a),
                        .D      (sram_d),
                        .OEN    (sram_oen)
                       );

bt_sram_8kx8 U_bist(
                     .b_clk       (bist_clk),
                     .b_rst_n     (sram_rst_n),
                     .b_te        (bist_en),
		     //--------------------------------------------------------
		     //All the input signals will be derectly connected to
		     //the sram input when in normal operation; and when in
		     //BIST TEST mode, there are some mux in BIST module
		     //selcting all sram input signals which generated by itself:
		     //sram controll signals, sram write data, etc.
		     //--------------------------------------------------------
                     .addr_fun     (sram_addr),
                     .wen_fun      (sram_wen_in),
                     .cen_fun      (sram_csn_in),
                     .oen_fun      (1'b0),
                     .data_fun     (sram_wdata),

                     .ram_read_out (sram_data_out),
                     .data_test    (sram_d),
                     .addr_test    (sram_a),
                     .wen_test     (sram_wen),
                     .cen_test     (sram_csn),
                     .oen_test     (sram_oen),

                     .b_done       (bist_done),
                     .b_fail       (bist_fail)
                    );

endmodule
