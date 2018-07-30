module apb2apb_async(/*autoarg*/
//outPuts
m_prdata,m_pready, m_pslverr, s_psel, s_penable, s_pwrite, 
s_paddr, s_pwdata,s_pprot,s_pstrb,
//InPuts
clk_apbm, rst_apbm_n, m_psel,m_penable, m_pwrite,m_paddr,
m_pwdata, m_pprot, m_pstrb, clk_apbs, rst_apbs_n, s_prdata,s_pready,s_pslverr
);

input clk_apbm;
input rst_apbm_n;

input m_psel;
input m_penable;
input m_pwrite;
input [31:0] m_paddr;
input [31:0] m_pwdata;
output [31:0] m_prdata;
output m_pready;
output m_pslverr;
input [2:0] m_pprot;
input [3:0] m_pstrb;


input clk_apbs;
input rst_apbs_n;

output s_psel;
output s_penable;
output s_pwrite;
output [31:0] s_paddr;
output [31:0] s_pwdata;
output [2:0] s_pprot;


output[3:0]s_pstrb;

input [31:0]s_prdata;
input s_pready;
input s_pslverr;



//aPB slave interface(clk_apbs domain)
wire m_paccess;
reg m_pactive_reg;
reg m_pwrite_reg;
reg [31:0] m_paddr_reg;
reg [31:0] m_pwdata_reg;
reg [2:0] m_pprot_reg;
reg [3:0] m_pstrb_reg;

wire [31:0] m_prdata;
wire      m_pready;
wire      m_pslverr;

//handshake
reg m_req;
reg s_req_sync1;
reg s_req_sync2;
reg s_req_sync3;
wire s_req_pls;

reg s_ack;
reg m_ack_sync1;
reg m_ack_sync2;
reg m_ack_sync3;
wire m_ack_pls;

reg s_pactive_reg;
wire s_psel;
wire s_penable;
wire s_pwrite;

wire [31:0] s_paddr;
wire [31:0] s_pwdata;
wire [2:0]s_pprot;
wire [3:0]s_pstrb;

reg [31:0] s_prdata_reg;
reg s_pslverr_reg;


//=====================
//Loglc
//APB master interface(clk_apbm domain)
//=====================

assign m_paccess = m_psel& ~m_penable& ~m_pactive_reg;
always @ (posedge clk_apbm or negedge rst_apbm_n)begin
    if(!rst_apbm_n)begin
       m_pactive_reg <= 1'b0;
    end 
    else if (!m_pactive_reg &&m_paccess) begin
       m_pactive_reg <= 1'b1;
    end
    else if(m_pactive_reg && m_ack_pls) begin
	    m_pactive_reg <= 1'b0;
    end
end

always @ (posedge clk_apbm or negedge rst_apbm_n)begin
    if (!rst_apbm_n)begin
        m_pwrite_reg <= 0;
        m_paddr_reg  <= 32'h0;
        m_pwdata_reg <= 32'h0;
        m_pprot_reg  <= 3'h0;
        m_pstrb_reg  <= 4'hF;
    end 
    else if (m_paccess)begin
      	m_pwrite_reg <= m_pwrite;
        m_paddr_reg <= m_paddr;
        m_pwdata_reg <= m_pwdata;
        m_pprot_reg <=  m_pprot;
        m_pstrb_reg <=   m_pstrb;
    end
end

assign m_prdata = s_prdata_reg & {32{m_pready}}; 
assign m_pready = ~m_pactive_reg | m_ack_pls;
assign m_pslverr = s_pslverr_reg & m_ack_pls;
////////////////////////////////////////////
// Handshake(clk_apbm and clk_apbs domain)
////////////////////////////////////////////

always @(posedge clk_apbm or negedge rst_apbm_n) begin
   if(!rst_apbm_n) begin
     m_req <= 1'b0;
   end
   else if(m_paccess) begin
     m_req <= ~m_req;
   end
end

always @(posedge clk_apbs or negedge rst_apbs_n)begin
   if(!rst_apbs_n)begin
     s_req_sync1 <= 1'b0;
     s_req_sync2 <= 1'b0;
     s_req_sync3 <= 1'b0;
   end
   else begin
     s_req_sync1 <= m_req;
     s_req_sync2 <= s_req_sync1;
     s_req_sync3 <= s_req_sync2;
   end
end

assign s_req_pls = s_req_sync2 ^ s_req_sync3;

always @ (posedge clk_apbs or negedge rst_apbs_n)begin
    if(!rst_apbs_n)begin
        s_ack <= 1'b0;
    end
    else if(s_pactive_reg&&s_pready)begin
        s_ack <=~s_ack;
    end
end

always @(posedge clk_apbm or negedge rst_apbm_n) begin
   if(!rst_apbm_n)begin
     m_ack_sync1 <= 1'b0;
     m_ack_sync2 <= 1'b0;
     m_ack_sync3 <= 1'b0;
   end
   else begin
     m_ack_sync1 <= s_ack;
     m_ack_sync2 <= m_ack_sync1;
     m_ack_sync3 <= m_ack_sync2;
   end
end
assign m_ack_pls = m_ack_sync2 ^ m_ack_sync3;
////////////////////////////////////////////
//APB slave interface(clk_aPbs domain)
////////////////////////////////////////////
always @(posedge clk_apbs or negedge rst_apbs_n) begin
   if(!rst_apbs_n)begin
      s_pactive_reg <= 1'b0;
   end
   else if (!s_pactive_reg && s_req_pls)begin
      s_pactive_reg <= 1'b1 ;
   end
   else if(s_pactive_reg && s_pready)begin 
      s_pactive_reg <= 1'b0;
   end
end
assign s_psel = s_req_pls | s_pactive_reg;

assign s_penable = s_pactive_reg;

assign s_pwrite = s_psel & m_pwrite_reg;
assign s_paddr = {32{s_psel}} & m_paddr_reg[31:0];
assign s_pwdata = {32{s_psel}} & m_pwdata_reg[31:0];
assign s_pprot = {3{s_psel}} && m_pprot_reg[2:0];
assign s_pstrb = {4{s_psel}} && m_pstrb_reg[3:0];

always @(posedge clk_apbs or negedge rst_apbs_n) begin
   if(!rst_apbs_n)begin
      s_prdata_reg <= 32'h0;
   end
   else if(s_pactive_reg &&!s_pwrite && s_pready)begin
      s_prdata_reg <= s_prdata;
   end
end

always @ (posedge clk_apbs or negedge rst_apbs_n) begin 
   if (!rst_apbs_n) begin
    	s_pslverr_reg <= 1'b0;
    end 
    else if(s_pactive_reg&& s_pready) begin 
    	s_pslverr_reg <= s_pslverr;
    end
end

endmodule


