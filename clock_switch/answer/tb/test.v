module test ();
wire [31:0] m_prdata;
wire m_pready;
wire m_pslverr;
wire s_psel;
wire s_penable;
wire s_pwrite;
wire [31:0] s_paddr;
wire [31:0] s_pwdata;
wire [2:0] s_pprot;
wire [3:0] s_pstrb;

reg clk_apbm;
reg rst_apbm_n;
reg m_psel;
reg m_penable;
reg m_pwrite;
reg [31:0] m_paddr;
reg [31:0] m_pwdata;
reg [2:0] m_pprot;
reg [3:0] m_pstrb;
reg clk_apbs;
reg rst_apbs_n;
wire [31:0] s_prdata;
reg s_pready;
reg s_pslverr;

initial begin
  rst_apbm_n = 0;
  rst_apbs_n = 0;
  clk_apbm = 0;
  clk_apbs = 0;
  m_pprot = 0;
  m_pstrb = 4'hF;
  s_pready = 1;
  s_pslverr = 0;
  repeat (5) @(posedge clk_apbm);  
  rst_apbm_n = 1;
  rst_apbs_n = 1;
  repeat (5) @(posedge clk_apbm);
  apb_write(32'h4031, 32'hA0AF);
  repeat (2) @(posedge clk_apbm);
  apb_write(32'h1011, 32'h7895);
  repeat (2) @(posedge clk_apbm);
  $finish;
end

initial begin
$fsdbDumpfile(0, "test.fsdb");
$fsdbDumpvars;
end

always #9 clk_apbm = ~clk_apbm ;
always #11 clk_apbs = ~clk_apbs ;

apb2apb_async u_design (
  .m_prdata     (m_prdata    ),  
  .m_pready     (m_pready    ),           
  .m_pslverr    (m_pslverr   ),            
  .s_psel       (s_psel      ),         
  .s_penable    (s_penable   ),            
  .s_pwrite     (s_pwrite    ),           
  .s_paddr      (s_paddr     ),          
  .s_pwdata     (s_pwdata    ),          
  .s_pprot      (s_pprot     ),         
  .s_pstrb      (s_pstrb     ),         
                
  .clk_apbm     (clk_apbm    ),          
  .rst_apbm_n   (rst_apbm_n  ),            
  .m_psel       (m_psel      ),        
  .m_penable    (m_penable   ),           
  .m_pwrite     (m_pwrite    ),          
  .m_paddr      (m_paddr     ),         
  .m_pwdata     (m_pwdata    ),           
  .m_pprot      (m_pprot     ),          
  .m_pstrb      (m_pstrb     ),               
  .clk_apbs     (clk_apbs    ),               
  .rst_apbs_n   (rst_apbs_n  ),               
  .s_prdata     (s_prdata    ),               
  .s_pready     (s_pready    ),               
  .s_pslverr    (s_pslverr   )                   
);


task apb_write(input reg [31:0] ADDR_M, input reg [31:0] WDATA_M);
begin
  @(posedge clk_apbm);
  m_paddr = 0;
  m_pwrite = 0;
  m_psel = 0;
  m_penable = 0;
  m_pwdata = 0;
  s_pready = 1;

  @(posedge clk_apbm);
  m_paddr = ADDR_M;
  m_pwrite = 1;
  m_psel = 1;
  m_penable = 0;
  m_pwdata = WDATA_M;
  @(posedge clk_apbm);
  m_psel = 1;
  m_penable = 1;
  @(posedge clk_apbm);
  m_psel = 0;
  m_penable = 0;
  m_pwdata = 0;
  @(posedge clk_apbm);
  m_paddr = 0;
  m_pwrite = 0;
  m_psel = 0;
  m_penable = 0;
  m_pwdata = 0;
  wait(m_pready == 1'b1);
end
endtask

task apb_read;

endtask
endmodule
