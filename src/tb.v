`default_nettype none
`timescale 1ns/1ps

module tb (
    );

    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    wire [7:0] inputs;
    wire [7:0] outputs;

    toplevel_module toplevel_module (
        .io_in (inputs),
        .io_out (outputs)
    );

endmodule

