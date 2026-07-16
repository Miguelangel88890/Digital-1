module acc_spi_k_M (clk , rst , k , inc_k , w);
  input clk;
  input rst;
  input inc_k;
  output reg w;
  output reg [2:0] k;

always @(negedge clk) begin
  if (rst) begin
   k <= 0;
   w <= 0;
  end else begin
      if (inc_k)
        k <= k + 1;  
      if (k == 4)
          w <= 1;
  end
end
endmodule