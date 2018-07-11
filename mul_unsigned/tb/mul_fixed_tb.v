module mul_fixed_tb;

parameter WIDTH = 8;

reg  [WIDTH-1:  0] a;
wire [WIDTH*2-1:0] z;

reg                clk;

always #5 clk = ~clk;

mul_fixed #( .WIDTH(WIDTH))
             u_mul_fixed( .z(z), .a(a) );

initial begin
    a=0;
    clk=0;
#10 a=127;
#10 a=255;
#10 a=1;
#10 a=2;
#10 a=3;
#10 a=5;
#10 a=10;
#10 $finish;
end

initial begin
  $vcdpluson();
end

always @ (posedge clk) begin
  $display ("185 * %d = %d", a,z);
end
endmodule

