`include "add.v"
`include "sub.v"
`include "xor.v"
`include "movAndBranch.v"

module tb
(
);

  reg [7:0] dIn0, dIn1;
  reg [3:0] addrs;
  wire enable;
  wire [7:0] res [3:0];
  wire cOut, bOut, bcf, bbf, buc, toggleOut;

  addEight tbAdder(.dIn0(dIn0), .dIn1(dIn1), .enable(enable), .cOut(cOut), .dOut(res[0]));
  subEight tbSubtract(.dIn0(dIn0), .dIn1(dIn1), .enable(enable), .bOut(bOut), .dOut(res[1]));
  xorEight tbXor(.dIn0(dIn0), .dIn1(dIn1), .enable(enable), .dOut(res[2]));
  movAndBranch tbMov(.dIn0(dIn0), .addrs(addrs), .enable(enable), .bcf(bcf), .bbf(bbf), .buc(buc), .toggleOut(toggleOut), .dOut(res[3]));

  integer i;

  assign enable = 1'b1;

  initial
  begin
    $monitor("dIn0 %b\ndIn1 %b\naddrs %b\nenable %b\naddRes %b cOut %b\nsubRes %b bOut %b\nxorRes %b\nmovRes %b\nbcf %b bbf %b buc %b toggleOut %b\n", dIn0, dIn1, addrs, enable, res[0], cOut, res[1], bOut, res[2], res[3], bcf, bbf, buc, toggleOut);

    for(i = 0; i < 32; i = i + 1)
    begin
      dIn0 = 8'b00000011;
      dIn1 = 8'b00000001;
      addrs = i % 16;

      #1;
    end
  end

endmodule
