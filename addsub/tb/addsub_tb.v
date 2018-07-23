module addsub_tb;

parameter WIDTH = 4;

reg [WIDTH-1:0]  a,b;
reg              cin;
reg              sub;

wire [WIDTH-1:0] sum;
wire             cout;

reg              clk;

always #5 clk = ~clk;

addsub   #( .WIDTH(WIDTH))
  u_addsub( .sum(sum),
            .cout(cout),
            .a(a),
            .b(b),
            .cin(cin),
            .sub(sub)
          );

initial begin
  a   = 0;
  b   = 0;
  cin = 0;
  sub = 0;
  clk = 0;
#10 a   = 4'd10;
    b   = 4'd6;
    cin = 1;
#10 a   = 4'd4;
    b   = 4'd5;
    cin = 1;
#10 sub = 1;
    a   = 4'd4;
    b   = 4'd5;
    cin = 0;
#10 a   = 4'd12;
    b   = 4'd3;
    cin = 1;
#10 a   = 4'd15;
    b   = 4'd10;
    cin = 1;
#10 $finish;
end

initial begin 
  $vcdpluson();
end

always @ (posedge clk) begin
  if (sub) $display ("%d - %d - %d(cin) = %b, cout = %d", a,b,cin,sum,cout);
  else     $display ("%d + %d + %d(cin) = %d, cout = %d", a,b,cin,sum,cout);end

endmodule
