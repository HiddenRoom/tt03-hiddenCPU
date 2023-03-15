`include "ALU.v"

module tb
(
);

  wire [7:0] dIn0, dIn1;
  assign dIn0 = 8'b00100001;
  assign dIn1 = 8'b01100100;
  reg [1:0] opcode;
  reg [3:0] addrs;
  wire [7:0] aluRes;
  wire cOut, bOut, bcf, bbf, buc, toggleOut;

  alu tbAlu(.opcode(opcode), .addrs(addrs), .dIn0(dIn0), .dIn1(dIn1), .carry(cOut), .borrow(bOut), .bcf(bcf), .bbf(bbf), .buc(buc), .toggleOut(toggleOut), .dOut(aluRes));

  integer i;

  assign enable = 1'b1;

  initial
  begin
    $monitor("opcode %b\ndIn0 %b\ndIn1 %b\naddrs %b\ncOut %b\nbOut %b\nbcf %b bbf %b buc %b toggleOut %b\naluRes %b\n", opcode, dIn0, dIn1, addrs, cOut, bOut, bcf, bbf, buc, toggleOut, aluRes);

    for(i = 0; i < 32; i = i + 1)
    begin
      addrs = i % 16;
      opcode = i % 4;

      #1;
    end
  end

endmodule
