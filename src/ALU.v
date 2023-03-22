`ifndef __ALU__
`define __ALU__

`include "add.v"
`include "sub.v"
`include "xor.v"
`include "movAndBranch.v"

module alu
(
  input [1:0] opcode,
  input [3:0] addrs,
  input [7:0] dIn0,
  input [7:0] dIn1,

  output carry,
  output borrow,

  output carryEnable,

  output bcf,

  output memWrite,
  output memRead,

  output toggleOut,

  output [7:0] dOut
);

  wire [3:0] enable;

  wire [7:0] addRes;
  wire [7:0] addIn0;
  wire [7:0] addIn1;
  wire [7:0] subRes;
  wire [7:0] subIn0;
  wire [7:0] subIn1;
  wire [7:0] xorRes;
  wire [7:0] xorIn0;
  wire [7:0] xorIn1;
  wire [7:0] movIn0;
  wire [7:0] movRes;

  twoFourDecode opcodeDecoder(.sel(opcode), .enable(enable));

  assign {addIn0, addIn1} = {dIn0, dIn1};
  assign {subIn0, subIn1} = {dIn0, dIn1};
  assign {xorIn0, xorIn1} = {dIn0, dIn1};
  assign movIn0 = dIn1;

  or(carryEnable, enable[0], enable[1]);

  addEight aluAdd(.dIn0(addIn0), .dIn1(addIn1), .enable(enable[0]), .cOut(carry), .dOut(addRes));
  subEight aluSub(.dIn0(subIn0), .dIn1(subIn1), .enable(enable[1]), .bOut(borrow), .dOut(subRes));
  xorEight aluXor(.dIn0(xorIn0), .dIn1(xorIn1), .enable(enable[2]), .dOut(xorRes));
  movAndBranch aluMovAndBranch(.dIn0(movIn0), .addrs(addrs), .enable(enable[3]), .bcf(bcf), .memWrite(memWrite), .memRead(memRead), .toggleOut(toggleOut), .dOut(movRes));

  assign dOut = addRes | subRes | xorRes | movRes;

endmodule

`endif
