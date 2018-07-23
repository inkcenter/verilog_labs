module fifo_tb_wfaster;

parameter ADDR_WIDTH = 8, DATA_WIDTH  = 8;
parameter READ_CYCLE = 14, WRITE_CYCLE = 4;

wire r_empty;
wire [DATA_WIDTH-1:0] r_data;
reg  r_clk, pop,  r_rst_n;

wire w_full;
reg  [DATA_WIDTH-1:0] w_data;
reg  w_clk, push, w_rst_n;

//instantiate
fifo #( .ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
     u_fifo  ( .r_empty(r_empty),
               .r_data(r_data),
               .r_clk(r_clk),
               .pop(pop),
               .r_rst_n(r_rst_n),
               .w_full(w_full),
               .w_data(w_data),
               .w_clk(w_clk),
               .push(push),
               .w_rst_n(w_rst_n)
             );

//clock generate
always #(READ_CYCLE/2 ) r_clk = ~r_clk;
always #(WRITE_CYCLE/2) w_clk = ~w_clk;

task r_w_reset; begin
  r_rst_n = 1'b0; //read reset
  w_rst_n = 1'b0; //write reset
  @(posedge r_clk);
  r_rst_n = 1'b1; //read reset release
  @(posedge w_clk);
  w_rst_n = 1'b1; //write reset release
  @(posedge w_clk);
end
endtask

task pop_pulse; begin
  pop = 1'b1;
  @(negedge r_clk);
  pop = 1'b0;
  @(posedge r_clk);
end
endtask

task push_pulse; begin
  push = 1'b1;
  @(negedge w_clk);
  push = 1'b0;
  @(posedge w_clk);
end
endtask

//stimulus
initial begin
    r_clk   = 1'b0;
    pop     = 1'b0;
    r_rst_n = 1'b1;
    w_data  =    0; //all 0
    w_clk   = 1'b0;
    push    = 1'b0;
    w_rst_n = 1'b1;
#1  r_w_reset;
#20000 $finish;
end

initial fork
#8000
  forever begin
    @(negedge r_clk)
      pop_pulse;    //ignore empty see what will happen
  end

  repeat(300) begin
    @(negedge w_clk)
      push_pulse;   //ignore full  see what will happen
  end

  forever begin
    @(negedge w_clk)
      w_data = w_data + 1'b1;
  end
join

initial begin
  $vcdpluson();
end

endmodule

