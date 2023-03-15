`ifndef __MUX__
`define __MUX__

module twoOneMux
(
  input sel,

  input [7:0] dIn0,
  input [7:0] dIn1,

  output [7:0] dOut
);

  wire [7:0] selExpanded;
  wire [7:0] notSelExpanded;

  wire [7:0] outTmp0;
  wire [7:0] outTmp1;

  assign selExpanded = {8{sel}};
  assign notSelExpanded = ~selExpanded;

  assign outTmp0 = dIn0 & notSelExpanded;
  assign outTmp1 = dIn1 & selExpanded;

  assign dOut = outTmp0 | outTmp1;

endmodule

module fourOneMux
(
  input [1:0] sel,

  input [7:0] dIn0,
  input [7:0] dIn1,
  input [7:0] dIn2,
  input [7:0] dIn3,

  output [7:0] dOut
);

  wire [7:0] selExpanded [1:0];
  wire [7:0] notSelExpanded [1:0];

  wire [7:0] outTmp [3:0];

  assign selExpanded[0] = {8{sel[0]}};
  assign selExpanded[1] = {8{sel[1]}};
  assign notSelExpanded[0] = ~selExpanded[0];
  assign notSelExpanded[1] = ~selExpanded[1];

  assign outTmp[0] = dIn0 & notSelExpanded[0] & notSelExpanded[1];
  assign outTmp[2] = dIn1 & selExpanded[0] & notSelExpanded[1];
  assign outTmp[1] = dIn2 & notSelExpanded[0] & selExpanded[1];
  assign outTmp[3] = dIn3 & selExpanded[0] & selExpanded[1];

  assign dOut = outTmp[0] | outTmp[1] | outTmp[2] | outTmp[3];

endmodule

`endif
