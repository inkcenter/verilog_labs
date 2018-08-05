module top3buf_tb;
parameter ADDR_WIDTH = 7, DATA_WIDTH = 16, LENGTH = 100;

logic [DATA_WIDTH-1:0] data_out_0, data_out_1, data_out_2;
logic [DATA_WIDTH-1:0] data_in;
logic                  out_valid, in_valid;
logic                  clk, rst_n;

always #10 clk = ~clk;

integer i,j;
initial begin
  clk   = 0;
  rst_n = 0;
  in_valid = 0;
  data_in  = 0;
  #100
  rst_n = 1;
  in_valid = 1;
  #10
  forever begin
    for (i=0;i<3;i=i+1) begin
      for (j=0;j<100;j=j+1) begin
        #1 data_in = i*128 + j;
        @(posedge clk);
      end
    end
  end
end

initial begin
  #10000 $finish;
end

initial begin
  $fsdbDumpfile("top3buf.fsdb");
  $fsdbDumpvars(0,top3buf_tb);
end

top3buf #( .ADDR_WIDTH(ADDR_WIDTH),
           .DATA_WIDTH(DATA_WIDTH),
           .LENGTH(LENGTH)
         )
  u_top3buf (
    .data_out_0(data_out_0),
    .data_out_1(data_out_1),
    .data_out_2(data_out_2),
    .out_valid(out_valid),
    .data_in(data_in),
    .in_valid(in_valid),
    .clk(clk),
    .rst_n(rst_n)
  );

endmodule

