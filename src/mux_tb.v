`include "mux.v"

module tb
(
);

  reg [1:0] selFourOne;
  wire [7:0] dInFourOne [3:0];
  wire [7:0] dOutFourOne;
  reg selTwoOne;
  wire [7:0] dInTwoOne [1:0];
  wire [7:0] dOutTwoOne;

  assign dInFourOne[0] = 8'b10000000;
  assign dInFourOne[1] = 8'b11000000;
  assign dInFourOne[2] = 8'b11100000;
  assign dInFourOne[3] = 8'b11110000;

  fourOneMux tbFourOneMux(.sel(selFourOne), .dIn0(dInFourOne[0]), .dIn1(dInFourOne[1]), .dIn2(dInFourOne[2]), .dIn3(dInFourOne[3]), .dOut(dOutFourOne));
  twoOneMux tbTwoOneMux(.sel(selTwoOne), .dIn0(dInTwoOne[0]), .dIn1(dInTwoOne[1]), .dOut(dOutTwoOne));

  assign dInTwoOne[0] = 8'b10000000;
  assign dInTwoOne[1] = 8'b11000000;

  integer i;

  initial
  begin
    $monitor("fourOneMux\nsel %b\ndIn0 %b dIn1 %b dIn2 %b dIn3 %b\ndOut %b\n", selFourOne, dInFourOne[0], dInFourOne[1], dInFourOne[2], dInFourOne[3], dOutFourOne);
    //$monitor("twoOneMux\nsel %b\ndIn0 %b dIn1 %b\ndOut %b\n", selTwoOne, dInTwoOne[0], dInTwoOne[1], dOutTwoOne);

    for(i = 0; i < 4; i = i + 1)
    begin
      selFourOne = i;
      selTwoOne = i % 2;

      #1;
    end
  end

endmodule
