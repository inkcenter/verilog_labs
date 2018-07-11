module mul_unsigned_tb;

parameter WIDTH = 4;

reg  [WIDTH-1:  0] a,b;
wire [WIDTH*2-1:0] z;

reg                clk;

always #5 clk = ~clk;

mul_unsigned #( .WIDTH(WIDTH))
             u_mul_unsigned( .z(z), .a(a), .b(b));

initial begin
    a=0;
    b=0;
    clk=0;
#10 a=15;
    b=15;
#10 a=14;
    b=10;
#10 a=0;
    b=15;
#10 a=2;
    b=13;
#10 $finish;
end

initial begin
  $vcdpluson();
end

always @ (posedge clk) begin
  $display ("%d * %d = %d", a,b,z);
end
endmodule


