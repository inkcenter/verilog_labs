module mul_unsigned_for4
#(parameter WIDTH = 4)(
  output [WIDTH*2-1:0] z,
  input  [WIDTH-1  :0] a,
  input  [WIDTH-1  :0] b
);

reg [WIDTH-1  :0] ab_array [WIDTH-1:0];
//reg [WIDTH*2-1:0] ab_shift [WIDTH-1:0];


always @ (*) begin: array_gen
  integer i,j;
  for (i=0;i<WIDTH;i=i+1) begin    //array[i][7:0]
    for (j=0;j<WIDTH;j=j+1) begin  //reg[j]
      ab_array[i][j] = a[i] & b[j];
    end
  end
end


wire [WIDTH*2-1:0] ab_shift_0 = { {WIDTH{1'b0}    }, ab_array[0][WIDTH-1:0]            };
wire [WIDTH*2-1:0] ab_shift_1 = { {(WIDTH-1){1'b0}}, ab_array[1][WIDTH-1:0], {1{1'b0}} };
wire [WIDTH*2-1:0] ab_shift_2 = { {(WIDTH-2){1'b0}}, ab_array[2][WIDTH-1:0], {2{1'b0}} };
wire [WIDTH*2-1:0] ab_shift_3 = { {(WIDTH-3){1'b0}}, ab_array[3][WIDTH-1:0], {3{1'b0}} };


assign z = ( (ab_shift_0 + ab_shift_1)   + 
             (ab_shift_2 + ab_shift_3) );
endmodule
