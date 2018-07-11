module mul_unsigned
#(parameter WIDTH = 4)(
  output [WIDTH*2-1:0] z,
  input  [WIDTH-1  :0] a,
  input  [WIDTH-1  :0] b
);

wire [WIDTH-1:0]   ab0 = b[0] ? a : {WIDTH{1'b0}};
wire [WIDTH-1:0]   ab1 = b[1] ? a : {WIDTH{1'b0}};
wire [WIDTH-1:0]   ab2 = b[2] ? a : {WIDTH{1'b0}};
wire [WIDTH-1:0]   ab3 = b[3] ? a : {WIDTH{1'b0}};

wire [WIDTH*2-1:0] s0  = {{WIDTH{1'b0}},     ab0      };
wire [WIDTH*2-1:0] s1  = {{(WIDTH-1){1'b0}}, ab1, 1'b0};
wire [WIDTH*2-1:0] s2  = {{(WIDTH-2){1'b0}}, ab2, 2'b0};
wire [WIDTH*2-1:0] s3  = {{(WIDTH-3){1'b0}}, ab3, 3'b0};

assign z = ((s0 + s1) + (s2 + s3));

endmodule
