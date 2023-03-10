`ifndef __DECODE__
`define __DECODE__

module twoFourDecode
(
  input [1:0] sel,

  output [3:0] enable
);

  wire [1:0] notSel;

  assign notSel[0] = ~sel[0];
  assign notSel[1] = ~sel[1];

  assign enable[0] = notSel[1] & notSel[0];
  assign enable[1] = notSel[1] & sel[0];
  assign enable[2] = sel[1] & notSel[0];
  assign enable[3] = sel[1] & sel[0];

endmodule

`endif
