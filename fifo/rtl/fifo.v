module fifo
#(parameter ADDR_WIDTH = 3, DATA_WIDTH = 8)(
  //read clock domain
  output                  r_empty,
  output [DATA_WIDTH-1:0] r_data,
  input                   r_clk,
  input                   pop,   //read enable //read increase
  input                   r_rst_n,
  //write clock domain
  output                  w_full,
  input  [DATA_WIDTH-1:0] w_data,
  input                   w_clk,
  input                   push,  //write enable //write increase
  input                   w_rst_n
);

//preclaim interface
wire r_en, w_en;
reg  [ADDR_WIDTH  :0] r_ptr_x, w_ptr_x;
wire [ADDR_WIDTH-1:0] r_ptr,   w_ptr;
wire [ADDR_WIDTH  :0] r_ptr_gray, w_ptr_gray;
reg  [ADDR_WIDTH  :0] r_ptr_sync, w_ptr_sync;

assign r_ptr = r_ptr_x[ADDR_WIDTH-1:0];
assign w_ptr = w_ptr_x[ADDR_WIDTH-1:0];

assign r_en = pop  && !r_empty;
assign w_en = push && !w_full;

//read & write pointer increase when push & pop @ clk
always @ (posedge r_clk or negedge r_rst_n) begin
  if (!r_rst_n) begin
    r_ptr_x <= {(ADDR_WIDTH+1){1'b0}}; //all 0
  end else if (r_en) begin
    r_ptr_x <= r_ptr_x + 1'b1;
  end
end

always @ (posedge w_clk or negedge w_rst_n) begin
  if (!w_rst_n) begin
    w_ptr_x <= {(ADDR_WIDTH+1){1'b0}};
  end else if (w_en) begin
    w_ptr_x <= w_ptr_x + 1'b1;
  end
end

//read & write pointer/address bin2gray
function [ADDR_WIDTH:0] bin2gray(
  input [ADDR_WIDTH:0] bin
);
  integer i;
  for (i=0;i<ADDR_WIDTH;i=i+1) begin
    bin2gray[i] = bin[i] ^ bin[i+1];
  end
  bin2gray[ADDR_WIDTH] = bin[ADDR_WIDTH];
endfunction

assign r_ptr_gray = bin2gray(r_ptr_x);
assign w_ptr_gray = bin2gray(w_ptr_x);

//synchronize
reg [ADDR_WIDTH:0] r_ptr_sync0, w_ptr_sync0;
always @ (posedge w_clk or negedge w_rst_n) begin
  if(!w_rst_n) begin
    r_ptr_sync0 <= 0; //all 0
    r_ptr_sync  <= 0;
  end else begin
    r_ptr_sync0 <= r_ptr_gray;
    r_ptr_sync  <= r_ptr_sync0;
  end
end
always @ (posedge r_clk or negedge r_rst_n) begin
  if(!r_rst_n) begin
    w_ptr_sync0 <= 0; //all 0
    w_ptr_sync  <= 0;
  end else begin
    w_ptr_sync0 <= w_ptr_gray;
    w_ptr_sync  <= w_ptr_sync0;
  end
end

//generate empty & full signal
//assign r_empty = (r_ptr_sync == w_ptr_gray) ? 1'b1 : 1'b0;
//assign w_full  = ({~w_ptr_sync[ADDR_WIDTH],~w_ptr_sync[ADDR_WIDTH-1],
//            w_ptr_sync[ADDR_WIDTH-2:0]} == r_ptr_gray) ? 1'b1 : 1'b0;
//local address VS synchronized address
assign r_empty = (w_ptr_sync == r_ptr_gray) ? 1'b1 : 1'b0;
assign w_full  = ({~r_ptr_sync[ADDR_WIDTH],~r_ptr_sync[ADDR_WIDTH-1],
            r_ptr_sync[ADDR_WIDTH-2:0]} == w_ptr_gray) ? 1'b1 : 1'b0;
//RAM instantiate
RAM_DUAL_pseudo #( .ADDR_WIDTH(ADDR_WIDTH), 
                   .DATA_WIDTH(DATA_WIDTH))
            u_RAM( .data_out(r_data),
                   .data_in(w_data),
                   .r_addr(r_ptr),
                   .r_en(r_en),
                   .r_clk(r_clk),
                   .w_addr(w_ptr),
                   .w_en(w_en),
                   .w_clk(w_clk)
                 );

endmodule

