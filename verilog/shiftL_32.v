module shiftL_32 (clk , sh, rst, in_A, s_A);
  input clk;
  input sh;
  input rst;
  input [31:0] in_A;
  output reg [31:0] s_A;

always @(negedge clk)
  if (rst)
   s_A <= {16'b0 , in_A[15:0]};
  else
     begin
      if (sh)
        s_A <= {s_A[30:0],1'b0};
      else
        s_A <= s_A;
     end
endmodule