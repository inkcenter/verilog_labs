module mul_unsigned_for
#(parameter WIDTH = 8)(
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

//always @ (*) begin
//  ab_shift[0] = { {WIDTH{1'b0}    }, ab_array[0][WIDTH-1:0]            };
//  ab_shift[1] = { {(WIDTH-1){1'b0}}, ab_array[1][WIDTH-1:0], {1{1'b0}} };
//  ab_shift[2] = { {(WIDTH-2){1'b0}}, ab_array[2][WIDTH-1:0], {2{1'b0}} };
//  ab_shift[3] = { {(WIDTH-3){1'b0}}, ab_array[3][WIDTH-1:0], {3{1'b0}} };
//  ab_shift[4] = { {(WIDTH-4){1'b0}}, ab_array[4][WIDTH-1:0], {4{1'b0}} };
//  ab_shift[5] = { {(WIDTH-5){1'b0}}, ab_array[5][WIDTH-1:0], {5{1'b0}} };
//  ab_shift[6] = { {(WIDTH-6){1'b0}}, ab_array[6][WIDTH-1:0], {6{1'b0}} };
//  ab_shift[7] = { {(WIDTH-7){1'b0}}, ab_array[7][WIDTH-1:0], {7{1'b0}} };
//end

wire [WIDTH*2-1:0] ab_shift_0 = { {WIDTH{1'b0}    }, ab_array[0][WIDTH-1:0]            };
wire [WIDTH*2-1:0] ab_shift_1 = { {(WIDTH-1){1'b0}}, ab_array[1][WIDTH-1:0], {1{1'b0}} };
wire [WIDTH*2-1:0] ab_shift_2 = { {(WIDTH-2){1'b0}}, ab_array[2][WIDTH-1:0], {2{1'b0}} };
wire [WIDTH*2-1:0] ab_shift_3 = { {(WIDTH-3){1'b0}}, ab_array[3][WIDTH-1:0], {3{1'b0}} };
wire [WIDTH*2-1:0] ab_shift_4 = { {(WIDTH-4){1'b0}}, ab_array[4][WIDTH-1:0], {4{1'b0}} };
wire [WIDTH*2-1:0] ab_shift_5 = { {(WIDTH-5){1'b0}}, ab_array[5][WIDTH-1:0], {5{1'b0}} };
wire [WIDTH*2-1:0] ab_shift_6 = { {(WIDTH-6){1'b0}}, ab_array[6][WIDTH-1:0], {6{1'b0}} };
wire [WIDTH*2-1:0] ab_shift_7 = { {(WIDTH-7){1'b0}}, ab_array[7][WIDTH-1:0], {7{1'b0}} };


assign z = ( (ab_shift_0 + ab_shift_1)   + 
             (ab_shift_2 + ab_shift_3) ) +
           ( (ab_shift_4 + ab_shift_5)   + 
             (ab_shift_6 + ab_shift_7) ) ;

endmodule
