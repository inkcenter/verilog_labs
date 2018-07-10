module addsub
#(parameter WIDTH = 4)(
  output reg [WIDTH-1:0] sum,
  output reg             cout,
  input      [WIDTH-1:0] a,
  input      [WIDTH-1:0] b,
  input                  cin,
  input                  sub
);

always @ (*) begin
  if (!sub) {cout,sum} = a + b + cin;
  else      {cout,sum} = a - b - cin;
end

endmodule
