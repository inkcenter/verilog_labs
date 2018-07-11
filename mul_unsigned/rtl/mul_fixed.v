module mul_fixed
#(parameter WIDTH = 8)(
  output [WIDTH*2-1:0] z,
  input  [WIDTH-1  :0] a
);

wire [WIDTH*2-1:0] a_shift_0 = { {WIDTH{1'b0}    }, a            };


wire [WIDTH*2-1:0] a_shift_3 = { {(WIDTH-3){1'b0}}, a, {3{1'b0}} };
wire [WIDTH*2-1:0] a_shift_4 = { {(WIDTH-4){1'b0}}, a, {4{1'b0}} };
wire [WIDTH*2-1:0] a_shift_5 = { {(WIDTH-5){1'b0}}, a, {5{1'b0}} };

wire [WIDTH*2-1:0] a_shift_7 = { {(WIDTH-7){1'b0}}, a, {7{1'b0}} };

assign z = (a_shift_0 + 
                    ((a_shift_3 + a_shift_4) + (a_shift_5 + a_shift_7)) );

endmodule
