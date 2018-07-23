module sync
#(parameter ADDR_WIDTH = 10)
(
    output [ADDR_WIDTH:0] sync_ptr,
    input  [ADDR_WIDTH:0] ori_ptr,
    input                 sync_clk,
    input                 rst_n
);

reg [ADDR_WIDTH:0] sync_ptr_reg_0;
reg [ADDR_WIDTH:0] sync_ptr_reg_1;
assign sync_ptr = sync_ptr_reg_1;

always @ (posedge sync_clk or negedge rst_n) begin
    if (!rst_n) begin
        sync_ptr_reg_0 <= 0;
        sync_ptr_reg_1 <= 0;
    end else begin
        sync_ptr_reg_0 <= ori_ptr;
        sync_ptr_reg_1 <= sync_ptr_reg_0;
    end
end

endmodule

