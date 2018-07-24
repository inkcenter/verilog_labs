module write
#(parameter ADDR_WIDTH = 10)
(
    output                  w_full,
    output                  w_en,
    output [ADDR_WIDTH-1:0] w_ptr,
    output [ADDR_WIDTH  :0] w_ptr_gray,
    input  [ADDR_WIDTH  :0] r_ptr_sync,
    input                   w_push,
    input                   w_clk,
    input                   w_rst_n
);

reg [ADDR_WIDTH:0] w_ptr_x; //wirte pointer extend 1 bit at MSB
assign w_ptr = w_ptr_x[ADDR_WIDTH-1:0];
//pointer counter
always @ (posedge w_clk or negedge w_rst_n) begin
    if (!w_rst_n) begin
        w_ptr_x <= 0;
    end else if (w_en) begin
        w_ptr_x <= w_ptr_x + 1'b1;
    end
end
//convert binary to gray
bin2gray  #( .ADDR_WIDTH(ADDR_WIDTH))
    w_gray ( .gray(w_ptr_gray), .bin(w_ptr_x));
//generate full flag
assign w_full = ( {~w_ptr_gray[ADDR_WIDTH],~w_ptr_gray[ADDR_WIDTH-1],
                    w_ptr_gray[ADDR_WIDTH-2:0]} == r_ptr_sync ) ? 1'b1 : 1'b0;
//while not full enable write RAM
assign w_en   = w_push && !w_full;

endmodule
