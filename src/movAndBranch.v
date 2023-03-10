/* if given two different register addresses it will set the the result
* operand reg equal to the non result operand reg. if it receives the same
* address for both what would otherwise be a nop is repurposed for a branch as
* follows:
*
* result address    non result address    operation
* 00b               00b                   unconditional increment of program
*                                         counter by the value in r3
*
* 01b               01b                   increment program counter by value
*                                         r3 if carry flag is high  
*
* 10b               10b                   increment program counter by value
*                                         r3 if borrow flag is high  
*
* 11b               11b                   toggle output pins between being
*                                         wired to r3 or program counter
* */

module movAndBranch
(
  input [7:0] dIn0,
  input [3:0] addrs,
  input enable,


  output bcf,
  output bbf,
  output buc,

  output toggleOut,

  output [7:0] dOut
);

  wire [1:0] addrsEqualTmp;
  wire addrsEqual;

  assign addrsEqualTmp = addrs[3:2] ^ addrs[1:0];
  assign addrsEqual = ~(addrsEqualTmp[1] | addrsEqualTmp[0]);

  wire [3:0] flagEnable;

  twoFourDecode flagDecoder(.sel(addrs[1:0]), .enable(flagEnable));

  and(bcf, addrsEqual, flagEnable[0]);
  and(bbf, addrsEqual, flagEnable[1]);
  and(buc, addrsEqual, flagEnable[2]);
  and(toggleOut, addrsEqual, flagEnable[3]);

  assign dOut = dIn0 & {8{enable}};

endmodule
