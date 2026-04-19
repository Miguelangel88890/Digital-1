module shiftR_32 (clk , sh, rst, n);
  input clk;
  input sh;
  input rst;
  output reg [31:0] n;

always @(negedge clk)
  if (rst)
   n <= 32'b1 << 5; 
  else
     begin
      if (sh)
        n <= {1'b0,n[31:1]};
      else
        n <= {n[30:0],1'b0};
     end
endmodule