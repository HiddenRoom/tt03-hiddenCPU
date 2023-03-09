module 
(
  input [7:0] dIn0,
  input enable

  input [7:0] dOut
);

  assign dOut = dIn0 & {8{enable}};

endmodule
