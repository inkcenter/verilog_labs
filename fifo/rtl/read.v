module read
#(parameter ADDR_WIDTH = 10)
(
    output                  r_empty,
    output                  r_en,
    output [ADDR_WIDTH-1:0] r_ptr,
    output [ADDR_WIDTH  :0] r_ptr_gray,
    input  [ADDR_WIDTH  :0] w_ptr_sync,
    input                   r_pop,
    input                   r_clk,
    input                   r_rst_n
);

reg [ADDR_WIDTH:0] r_ptr_x; //wirte pointer extend 1 bit at MSB
assign r_ptr = r_ptr_x[ADDR_WIDTH-1:0];
//pointer counter
always @ (posedge r_clk or negedge r_rst_n) begin
    if (!r_rst_n) begin
        r_ptr_x <= 0;
    end else if (r_en) begin
        r_ptr_x <= r_ptr_x + 1'b1;
    end
end
//convert binary to gray
bin2gray  #( .ADDR_WIDTH(ADDR_WIDTH))
    r_gray ( .gray(r_ptr_gray), .bin(r_ptr_x));
//generate full flag
assign r_empty = ( w_ptr_sync == r_ptr_gray ) ? 1'b1 : 1'b0;
//while not full enable write RAM
assign r_en    = r_pop && !r_empty;

endmodule
