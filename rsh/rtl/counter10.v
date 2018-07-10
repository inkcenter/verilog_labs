module counter10(
  output reg  [3:0] dout,
  output reg        cout,
  input  wire       clock,
  input  wire       reset_n,
  input  wire       enable,
  input  wire       load,
  input  wire [3:0] din
);

  always @ (posedge clock or negedge reset_n) begin
    if (!reset_n) begin
      dout <= 4'b0;
      cout <= 1'b0;
    end else if (load) begin
      dout <= din;
    end else if (enable) begin
      if (dout == 4'b1001) begin
        dout <= 4'b0;
        cout <= cout + 1;
      end else begin
        dout <= dout + 1;
      end
    end else begin
      dout <= dout;
    end
  end

endmodule
