module shiftR_16_M (clk , sh, rst, in_B, s_B);
  input clk;
  input sh;
  input rst;
  input [15:0]in_B;
  output reg [15:0] s_B;

always @(negedge clk)
  if (rst)
    s_B <= in_B;
  else
     begin
      if (sh)
        s_B <= {1'b0,s_B[15:1]};
      else
        s_B <= s_B;
     end
endmodule