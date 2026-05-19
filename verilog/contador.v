module contador (clk , A, count, rst);
  input clk;
  input count;
  input rst;
  output reg [15:0] A;

always @(negedge clk)
  if (rst)
   A <= 16'h00000000;
  else
     begin
      if (count)
        A <= A + 1;
      else
        A <= A;
     end
endmodule