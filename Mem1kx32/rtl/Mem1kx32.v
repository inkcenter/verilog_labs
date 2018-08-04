module Mem1k32
#(parameter AddrWidth = 10,
  parameter MemWidth  = 32)(
  output Valid,         // Data valid during a read.
  output ParityErr,
  output [MemWidth -1:0] DataO,
  input  [MemWidth -1:0] DataI,
  input  [AddrWidth-1:0] Addr,
  input  clk,
  input  ChipEn,        // Enables data output drivers
  input  Read,
  input  Write
);

localparam MemDepth = (1 << (AddrWidth)); //RAM depth

reg [MemWidth:0] Memory[MemDepth-1:0];    //bit 32 is parity

reg [MemWidth-1:0] DataO_reg;
reg                Valid_reg;
reg                ParityErr;

wire               clk_wire;
assign clk_wire = (ChipEn==1'b1) ? clk : 1'b0;

assign Valid    = (ChipEn==1'b1) ? Valid_reg : 1'b0;
assign DataO    = (ChipEn==1'b1) ? DataO_reg : 1'b0;



always @ (posedge clk_wire) begin
  if (ChipEn) begin                //neccessary???
    if (Read) begin
      ParityErr <= ^Memory[Addr];  //Parity check
      DataO_reg <= Memory[Addr][MemWidth-1:0];
      if (Write) Valid_reg <= 1'b0; //Read=1 Write=1, read but invalid
      else       Valid_reg <= 1'b1; //Read=1 Write=0, read and valid
    end else if (Write) begin
      Memory[Addr] <= {^DataI, DataI}; 
      Valid_reg    <= 1'b0;         //Read=0 Write=1, write and invalid
    end else begin
      Valid_reg    <= 1'b0;         //Read=0 Write=0, read reg and invalid
    end
  end
end

endmodule

