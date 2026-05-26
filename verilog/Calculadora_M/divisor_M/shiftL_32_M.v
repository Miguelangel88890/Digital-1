module shiftL_32_M (clk , sh, rst, in_A, s_A);
  input clk;
  input sh;
  input rst;
  input [31:0] in_A;
  output reg [31:0] s_A;

always @(negedge clk)
  if (rst)
   s_A <= s_A;
  else
     begin
      if (sh)
        s_A <= {s_A[31:0],1'b0};
      else
        s_A <= s_A;
     end
endmodule