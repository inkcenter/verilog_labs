module fifo_top_tb;

parameter ADDR_WIDTH  = 8 , DATA_WIDTH = 8;
parameter WRITE_CYCLE = 14, READ_CYCLE = 4;

wire w_full;
reg [DATA_WIDTH-1:0] w_data;
reg w_clk, w_push;

wire r_empty;
reg [DATA_WIDTH-1:0] r_data;
reg r_clk, r_pop;

reg rst_n;

fifo_top #( .ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
    u_fifo_top ( .w_full(w_full),
                 .w_data(w_data),
                 .w_push(w_push),
                 .w_clk(w_clk),
                 .r_empty(r_empty),
                 .r_data(r_data),
                 .r_pop(r_pop),
                 .r_clk(r_clk),
                 .rst_n(rst_n)
               );

//clock generate
always #(WRITE_CYCLE/2) w_clk = ~w_clk;
always #(READ_CYCLE/2)  r_clk = ~r_clk;

initial begin
        w_data = 0;
        w_clk  = 1'b0;
        w_push = 1'b0;
        r_clk  = 1'b0;
        r_pop  = 1'b0;
        rst_n  = 1'b1;
    #1  rst_n  = 1'b0;
    @(posedge w_clk);
        rst_n  = 1'b1;
    #1  w_push = 1'b1;
    #5000 r_pop = 1'b1;
    #2000 w_push= 1'b1;
          r_pop = 1'b0;
    #5000 w_push= 1'b0;
          r_pop = 1'b1;
    #2000 w_push= 1'b1;
          r_pop = 1'b0;
    #5000 w_push= 1'b0;
          r_pop = 1'b1;
    #2000 w_push= 1'b1;
          r_pop = 1'b0;
    #5000 $finish;
end

initial begin
    forever begin
        @(negedge w_clk)
        if (!w_full) begin
            w_data = w_data + 1'b1;
        end
    end
end

initial begin
    $vcdpluson();
end

endmodule
