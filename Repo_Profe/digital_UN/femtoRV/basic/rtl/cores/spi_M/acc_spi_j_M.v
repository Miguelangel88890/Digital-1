module acc_spi_j_M (clk , rst , j , sh , c);
  input clk;
  input rst;
  input sh;
  output reg c;
  output reg [4:0] j;

always @(negedge clk) begin
  if (rst) begin
   c <= 0;
   j <= 0;
  end else begin
      if (sh)
        j <= j + 1;  
      if (j == 16)
          c <= 1;
  end
end
endmodule