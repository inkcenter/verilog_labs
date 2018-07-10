module seq_det_sr(
  output flag,
  input  clk,
  input  rst_n,
  input  seq_in
);

reg [6:0] data_out;

always @ (posedge clk or negedge rst_n) begin
  if (!rst_n) data_out <= 7'd0;
  else        data_out <= { data_out[5:0] , seq_in };
end

assign flag = ((data_out[6]==1) && (data_out[5]==0) && (data_out[4]==1) && (data_out[3]==1) && (data_out[2]==0) && (data_out[1]==1) && (data_out[0]==0)) ? 1'b1 : 1'b0;

endmodule
