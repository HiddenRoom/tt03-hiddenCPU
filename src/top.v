`default_nettype none

module HiddenRoom_HiddenCPU
(
  input [7:0] in,

  output [7:0] out
);

  wire clk, rst;

  assign clk = in[0];
  assign rst = in[1];

  wire [1:0] opcode;
  wire [1:0] reg0Addr;
  wire [1:0] reg1Addr;

  reg [7:0] pc;

  reg [7:0] r0;
  reg [7:0] r1;
  reg [7:0] r2;
  reg [7:0] r3;

  reg carryFlag;
  reg borrowFlag;

  always @(posedge clk)
  begin
    opcode = in[2:3];
    reg0Addr = in[4:5];
    reg1Addr = in[6:7];

    pc = pc + pcInc;
  end 

  always @(posedge rst)
  begin
    pc = 8'b00000000;

    r0 = 8'b00000000;
    r1 = 8'b00000001;
    r2 = 8'b00000010;
    r3 = 8'b00000011;
  end

  assign out = r3; /* to see cpu output */

endmodule
