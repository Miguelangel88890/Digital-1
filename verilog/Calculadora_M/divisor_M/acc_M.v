module acc_M (clk , i, addi, rst);
  input clk;
  input addi;
  input rst;
  output reg [5:0] i;

always @(negedge clk)
  if (rst)
   i <= 0;
  else
     begin
      if (addi)
        i <= i + 1;
      else
        i <= i;
     end
endmodule