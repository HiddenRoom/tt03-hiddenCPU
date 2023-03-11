`default_nettype none

`include "ALU.v"
`include "decode.v"
`include "mux.v"

module HiddenRoom_HiddenCPU
(
  input [7:0] in,

  output [7:0] out
);

  wire clk, rst;

  assign clk = in[0];
  assign rst = in[1];

  reg [1:0] opcode;
  reg [1:0] reg0Addr;
  reg [1:0] reg1Addr;

  wire [7:0] dIn0;
  wire [7:0] dIn1;

  fourOneMux reg0Mux(.sel(reg0Addr), .dIn0(r0), .dIn1(r1), .dIn2(r2), .dIn3(r3), .dOut(dIn0));
  fourOneMux reg1Mux(.sel(reg1Addr), .dIn0(r0), .dIn1(r1), .dIn2(r2), .dIn3(r3), .dOut(dIn1));

  wire [7:0] aluRes;
  wire [3:0] writeBackEnable;

  reg [7:0] pc;

  reg [7:0] r0;
  reg [7:0] r1;
  reg [7:0] r2;
  reg [7:0] r3;

  wire carryFlag;
  wire borrowFlag;

  wire bcf;
  wire bbf;
  wire buc;

  wire toggleOut;

  reg selOut;

  alu topAlu(.opcode(opcode), .addrs(in[5:2]), .dIn0(dIn0), .dIn1(dIn1), .carry(carryFlag), .borrow(borrowFlag), .bcf(bcf), .bbf(bbf), .buc(buc), .toggleOut(toggleOut), .dOut(aluRes));
  twoFourDecode writeBackAddrDecoder(.sel(reg0Addr), .enable(writeBackEnable));

  always @(posedge clk)
  begin
    if(rst)
    begin
      pc <= 8'b00000000;

      selOut <= 1'b0;

      r0 <= 8'b00000000;
      r1 <= 8'b00000001;
      r2 <= 8'b00000010;
      r3 <= 8'b00000011;
    end 

    opcode <= in[7:6];
    reg0Addr <= in[5:4];
    reg1Addr <= in[3:2];

    if(toggleOut)
    begin
      selOut <= !selOut;
    end
    else if((carryFlag & bcf) | (borrowFlag & bbf) | buc)
    begin
      pc <= pc + r3;
    end
    else
    begin
      pc <= pc + 1;
    end

    r0 <= aluRes & {8{writeBackEnable[0]}};
    r1 <= aluRes & {8{writeBackEnable[1]}};
    r2 <= aluRes & {8{writeBackEnable[2]}};
    r3 <= aluRes & {8{writeBackEnable[3]}};
  end 

  twoOneMux outputMux(.sel(selOut), .dIn0(pc), .dIn1(r3), .dOut(out));

endmodule
