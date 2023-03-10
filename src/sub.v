`ifndef __SUB__
`define __SUB__

module halfSubtractor
(
  input a,
  input b,

  output diff,
  output bOut
);
  
  wire notA;

  not(notA, a);

  xor(diff, a, b);
  and(bOut, notA, b);

endmodule

module fullSubtractor
(
  input a,
  input b,
  input bIn,

  output diff,
  output bOut
);

  wire borrowA, borrowB, diffAB;

  halfSubtractor halfSubtractorAB(.a(a), .b(b), .diff(diffAB), .bOut(borrowA));
  halfSubtractor halfSubtractorDiffABBIn(.a(diffAB), .b(bIn), .diff(diff), .bOut(borrowB));

  or(bOut, borrowA, borrowB);

endmodule

module subEight
(
  input [7:0] dIn0,
  input [7:0] dIn1,
  input enable,

  output bOut,
  output [7:0] dOut
);  

  wire [7:0] resTmp;

  wire [6:0] borrows;

  halfSubtractor subtractor0(.a(dIn0[0]), .b(dIn1[0]), .diff(resTmp[0]), .bOut(borrows[0]));
  fullSubtractor subtractor1(.a(dIn0[1]), .b(dIn1[1]), .bIn(borrows[0]), .diff(resTmp[1]), .bOut(borrows[1]));
  fullSubtractor subtractor2(.a(dIn0[2]), .b(dIn1[2]), .bIn(borrows[1]), .diff(resTmp[2]), .bOut(borrows[2]));
  fullSubtractor subtractor3(.a(dIn0[3]), .b(dIn1[3]), .bIn(borrows[2]), .diff(resTmp[3]), .bOut(borrows[3]));
  fullSubtractor subtractor4(.a(dIn0[4]), .b(dIn1[4]), .bIn(borrows[3]), .diff(resTmp[4]), .bOut(borrows[4]));
  fullSubtractor subtractor5(.a(dIn0[5]), .b(dIn1[5]), .bIn(borrows[4]), .diff(resTmp[5]), .bOut(borrows[5]));
  fullSubtractor subtractor6(.a(dIn0[6]), .b(dIn1[6]), .bIn(borrows[5]), .diff(resTmp[6]), .bOut(borrows[6]));
  fullSubtractor subtractor7(.a(dIn0[7]), .b(dIn1[7]), .bIn(borrows[6]), .diff(resTmp[7]), .bOut(bOut));

  assign dOut = resTmp & {8{enable}};
  
endmodule

`endif
