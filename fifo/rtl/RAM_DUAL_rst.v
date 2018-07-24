module RAM_DUAL_rst
#(parameter ADDR_WIDTH = 10, DATA_WIDTH = 32)
(//wirte clock
    input  [DATA_WIDTH-1:0] data_in,
    input  [ADDR_WIDTH-1:0] w_addr,
    input                   w_en,
    input                   w_clk,
 //read clock
    output [DATA_WIDTH-1:0] data_out,
    input  [ADDR_WIDTH-1:0] r_addr,
    input                   r_en,
    input                   r_clk,
 //reset
    input                   rst_n
);

localparam DATA_DEPTH = (1 << ADDR_WIDTH);
reg [DATA_WIDTH-1:0] memory [DATA_DEPTH-1:0];
reg [DATA_WIDTH-1:0] data_out_reg;
assign data_out = data_out_reg;

always @ (posedge w_clk or negedge rst_n) begin: WRITE_RAM
    if (!rst_n) begin: RESET_RAM
        integer i;
        for (i=0;i<DATA_DEPTH;i=i+1) begin
            memory[i] <= 0;
        end
    end else if (w_en) begin
        memory[w_addr] <= data_in;
    end
end

always @ (posedge r_clk or negedge rst_n) begin: READ_RAM
    if (!rst_n) begin
        data_out_reg <= 0;
    end else if (r_en) begin
        data_out_reg <= memory[r_addr];
    end
end

endmodule
