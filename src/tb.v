`default_nettype none
`timescale 1ns/1ps

module tb 
(
  input clk,
  input rst,
  input [5:0] instruction,

  output [7:0] outBus
);

    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    wire [7:0] inputs = {instruction, rst, clk};
    wire [7:0] outputs;
    assign outBus = outputs;

    HiddenRoom_HiddenCPU HiddenRoom_HiddenCPU (
        .io_in (inputs),
        .io_out (outputs)
    );

endmodule
