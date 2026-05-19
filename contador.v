module contador (clk , A, count, rst);
  input clk;
  input count;
  input rst;
  output reg [31:0] A;

always @(negedge clk)
  if (rst)
   A <= 32'h00000000;
  else
     begin
      if (count)
        A <= A + 1;
      else
        A <= A;
     end
endmodule