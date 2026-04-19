module shiftR_16 (clk , sh, rst, n);
  input clk;
  input sh;
  input rst;
  output reg [15:0] n;

always @(negedge clk)
  if (rst)
   n <= 16'b1 << 5; 
  else
     begin
      if (sh)
        n <= {1'b0,n[15:1]};
      else
        n <= {n[14:0],1'b0};
     end
endmodule