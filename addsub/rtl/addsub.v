module addsub
#(parameter WIDTH = 4)(
  output [WIDTH-1:0] sum,
  output             cout,
  input  [WIDTH-1:0] a,
  input  [WIDTH-1:0] b,
  input              cin,
  input              sub
);
  wire [WIDTH-1:0] b_tmp;
  wire             cin_tmp;
  wire             cout_tmp;

  assign b_tmp   = b ^ {WIDTH{sub}};
  assign cin_tmp = cin ^ sub;

  assign {cout_tmp,sum} = a + b_tmp + cin_tmp;
  assign cout = ~ cout_tmp;

endmodule
