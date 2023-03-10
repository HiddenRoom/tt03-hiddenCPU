module halfAdder
(
  input a,
  input b,

  output sum,
  output carry
);

  xor(sum, a, b);
  and(carry, a, b);

endmodule

module fullAdder
(
  input a,
  input b,
  input cIn,

  output sum,
  output cOut
);
  
  wire sumAB, carryAB, sumCInSumAB, carryCInSumAB;

  halfAdder halfAdderAB(.a(a), .b(b), .sum(sumAB), .carry(carryAB));
  halfAdder halfAdderCInSumAB(.a(cIn), .b(sumAB), .sum(sum), .carry(carryCInSumAB));

  or(cOut, carryAB, carryCInSumAB);

endmodule

module addEight
(
  input [7:0] dIn0,
  input [7:0] dIn1,
  input enable,

  output cOut,
  output [7:0] dOut
);  

  wire [7:0] resTmp;
  wire cOutTmp;
  
  wire [6:0] carries;

  halfAdder adder0(.a(dIn0[0]), .b(dIn1[0]), .sum(resTmp[0]), .carry(carries[0]));
  fullAdder adder1(.a(dIn0[1]), .b(dIn1[1]), .cIn(carries[0]), .sum(resTmp[1]), .cOut(carries[1]));
  fullAdder adder2(.a(dIn0[2]), .b(dIn1[2]), .cIn(carries[1]), .sum(resTmp[2]), .cOut(carries[2]));
  fullAdder adder3(.a(dIn0[3]), .b(dIn1[3]), .cIn(carries[2]), .sum(resTmp[3]), .cOut(carries[3]));
  fullAdder adder4(.a(dIn0[4]), .b(dIn1[4]), .cIn(carries[3]), .sum(resTmp[4]), .cOut(carries[4]));
  fullAdder adder5(.a(dIn0[5]), .b(dIn1[5]), .cIn(carries[4]), .sum(resTmp[5]), .cOut(carries[5]));
  fullAdder adder6(.a(dIn0[6]), .b(dIn1[6]), .cIn(carries[5]), .sum(resTmp[6]), .cOut(carries[6]));
  fullAdder adder7(.a(dIn0[7]), .b(dIn1[7]), .cIn(carries[6]), .sum(resTmp[7]), .cOut(cOutTmp));

  assign dOut = resTmp & {8{enable}};
  assign cOut = cOutTmp & enable;

endmodule
