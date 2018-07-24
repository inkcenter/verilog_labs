module fifo_top
#(parameter ADDR_WIDTH = 5, DATA_WIDTH = 8)
(//write clock domain
    output                  w_full,
    input  [DATA_WIDTH-1:0] w_data,
    input                   w_push,
    input                   w_clk,
 //read clock domain
    output                  r_empty,
    output [DATA_WIDTH-1:0] r_data,
    input                   r_pop,
    input                   r_clk,
 //shared reset for write & read
    input                   rst_n
);

wire [ADDR_WIDTH-1:0] w_ptr, r_ptr;
wire                  w_en, r_en;

wire [ADDR_WIDTH:0] w_ptr_gray, r_ptr_gray;
wire [ADDR_WIDTH:0] r_ptr_sync, w_ptr_sync;

write #( .ADDR_WIDTH(ADDR_WIDTH))
    u_write ( .w_full(w_full),
              .w_en(w_en),
              .w_ptr(w_ptr),
              .w_ptr_gray(w_ptr_gray),
              .r_ptr_sync(r_ptr_sync),
              .w_push(w_push),
              .w_clk(w_clk),
              .w_rst_n(rst_n)
            );

read #( .ADDR_WIDTH(ADDR_WIDTH))
    u_read ( .r_empty(r_empty),
             .r_en(r_en),
             .r_ptr(r_ptr),
             .r_ptr_gray(r_ptr_gray),
             .w_ptr_sync(w_ptr_sync),
             .r_pop(r_pop),
             .r_clk(r_clk),
             .r_rst_n(rst_n)
           );

sync #( .ADDR_WIDTH(ADDR_WIDTH))
    sync_w2r ( .sync_ptr(w_ptr_sync),
               .ori_ptr(w_ptr_gray),
               .sync_clk(r_clk),
               .rst_n(rst_n)
             );

sync #( .ADDR_WIDTH(ADDR_WIDTH))
    sync_r2w ( .sync_ptr(r_ptr_sync),
               .ori_ptr(r_ptr_gray),
               .sync_clk(w_clk),
               .rst_n(rst_n)
             );

RAM_DUAL_rst #( .ADDR_WIDTH(ADDR_WIDTH), 
                .DATA_WIDTH(DATA_WIDTH))
    u_RAM_DUAL ( .data_in(w_data),
                 .w_addr(w_ptr),
                 .w_en(w_en),
                 .w_clk(w_clk),
                 .data_out(r_data),
                 .r_addr(r_ptr),
                 .r_en(r_en),
                 .r_clk(r_clk),
                 .rst_n(rst_n)
               );

endmodule
