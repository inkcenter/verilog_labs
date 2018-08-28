module clac(
          ctrl,
          clac_mode,
          opcode_a,
          opcode_b,
          result
);

input ctrl;
input [1:0] clac_mode;
input [15:0] opcode_a;
input [15:0] opcode_b;

output [31:0] result;
reg    [31:0] result;

always@(*)
begin
  if(ctrl)
  case(clac_mode)
  2'b00: result = opcode_a & opcode_b;
  2'b01: result = opcode_a | opcode_b;
  2'b10: result = opcode_a ^ opcode_b;
  2'b11: result = opcode_a + opcode_b;
  endcase
  else
  result = 32'b0;
end

endmodule
