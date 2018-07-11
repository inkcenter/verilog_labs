module mul_unsigned_pipeline_tb;

parameter WIDTH = 8;

reg  [WIDTH-1:  0] a,b;
wire [WIDTH*2-1:0] z;

reg                clk;
reg                rst_n;

always #5 clk = ~clk;

mul_unsigned_pipeline #( .WIDTH(WIDTH))
             u_mul_pipeline_for( .z(z), .a(a), .b(b), 
                                 .clk(clk), .rst_n(rst_n)
                               );

initial begin
    a=0;
    b=0;
    clk=0;
    rst_n=1;
#1  rst_n=0;
#1  rst_n=1;

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

    rst_n=1;
#1  rst_n=0;
#1  rst_n=1;
#10 a=10;
    b=50;
#10 a=3;
    b=250;
#10 a=4;
    b=100;

#50 $finish;
end

initial begin
  $vcdpluson();
end

always @ (posedge clk) begin
  $display ("%d * %d = %d", a,b,z);
end
endmodule

