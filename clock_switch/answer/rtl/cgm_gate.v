module cell_ckgate (TE,E,CP,Q
);
input TE;
input E;
input CP;
output Q;
reg E_lat;
assign E_or = E | TE;

always @(CP or E_or)
  if (!CP) begin
    E_lat = E_or;
  end
  
assign Q = E_lat && CP;
endmodule
