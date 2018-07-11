module mul_unsigned_for_tb;

parameter WIDTH = 8;

reg  [WIDTH-1:  0] a,b;
wire [WIDTH*2-1:0] z;

reg                clk;

always #5 clk = ~clk;

mul_unsigned_for #( .WIDTH(WIDTH))
             u_mul_unsigned_for( .z(z), .a(a), .b(b));

initial begin
    a=0;
    b=0;
    clk=0;
#10 a=127;
    b=127;
#10 a=255;
    b=255;
#10 a=123;
    b=231;
#10 a=1;
    b=23;
#10 a=244;
    b=0;
#10 a=5;
    b=10;
#10 $finish;
end

initial begin
  $vcdpluson();
end

always @ (posedge clk) begin
  $display ("%d * %d = %d", a,b,z);
end
endmodule

