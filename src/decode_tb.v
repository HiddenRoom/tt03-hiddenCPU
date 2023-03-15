`include "decode.v"

module tb
(
);

  reg [1:0] sel;

  wire [3:0] enable;

  twoFourDecode tbDecoder(.sel(sel), .enable(enable));

  integer i;

  initial
  begin
    $monitor("sel %b\nenable %b\n", sel, enable);

    for(i = 0; i < 4; i = i + 1)
    begin
      sel = i;

      #1;
    end
  end

endmodule
