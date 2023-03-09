module xorEight
(
  input [7:0] dIn0,
  input [7:0] dIn1,
  input enable,

  output [7:0] dOut
);

  assign dOut = (dIn0 ^ dIn1) & {8{enable}};

endmodule
