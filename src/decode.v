module twoFourDecode
(
  input [1:0] i,

  output wire [3:0] enable
);

  wire [1:0] notI;

  assign notI[0] = ~i[0];
  assign notI[1] = ~i[1];

  assign enable[0] = notI[1] & notI[0];
  assign enable[1] = notI[1] & i[0];
  assign enable[2] = i[1] & notI[0];
  assign enable[3] = i[1] & i[0];

endmodule
