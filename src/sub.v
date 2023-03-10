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
  input [7:0] d0,
  input [7:0] d1,
  input enable,

  output bOut,
  output [7:0] dOut
);  

  wire [7:0] resTmp;

  wire [6:0] borrows;

  halfSubtractor subtractor0(.a(d0[0]), .b(d1[0]), .diff(resTmp[0]), .bOut(borrows[0]));
  fullSubtractor subtractor1(.a(d0[1]), .b(d1[1]), .bIn(borrows[0]), .diff(resTmp[1]), .bOut(borrows[1]));
  fullSubtractor subtractor2(.a(d0[2]), .b(d1[2]), .bIn(borrows[1]), .diff(resTmp[2]), .bOut(borrows[2]));
  fullSubtractor subtractor3(.a(d0[3]), .b(d1[3]), .bIn(borrows[2]), .diff(resTmp[3]), .bOut(borrows[3]));
  fullSubtractor subtractor4(.a(d0[4]), .b(d1[4]), .bIn(borrows[3]), .diff(resTmp[4]), .bOut(borrows[4]));
  fullSubtractor subtractor5(.a(d0[5]), .b(d1[5]), .bIn(borrows[4]), .diff(resTmp[5]), .bOut(borrows[5]));
  fullSubtractor subtractor6(.a(d0[6]), .b(d1[6]), .bIn(borrows[5]), .diff(resTmp[6]), .bOut(borrows[6]));
  fullSubtractor subtractor7(.a(d0[7]), .b(d1[7]), .bIn(borrows[6]), .diff(resTmp[7]), .bOut(bOut));

  assign dOut = resTmp & {8{enable}};
  
endmodule
