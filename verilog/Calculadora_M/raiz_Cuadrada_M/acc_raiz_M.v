module acc_raiz_M (clk , i, sh, rst , c);
  input clk;
  input sh;
  input rst;
  output reg c;
  output reg [5:0] i;

always @(negedge clk) begin
  if (rst) begin
   c <= 0;
   i <= 0;
  end else begin
      if (sh)
        i <= i + 1;
      if (i == 8)
          c <= 1;
  end
end
endmodule