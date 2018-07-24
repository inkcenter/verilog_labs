module bin2gray
#(parameter ADDR_WIDTH = 10)
(
    output [ADDR_WIDTH:0] gray,
    input  [ADDR_WIDTH:0] bin
);

reg [ADDR_WIDTH:0] gray_reg;
assign gray = gray_reg;

always @ (*) begin: ENCODER
    integer i;
    for (i=0;i<ADDR_WIDTH;i=i+1) begin
        gray_reg[i] = bin[i] ^ bin[i+1];
    end
    gray_reg[ADDR_WIDTH] = bin[ADDR_WIDTH];
end

endmodule
