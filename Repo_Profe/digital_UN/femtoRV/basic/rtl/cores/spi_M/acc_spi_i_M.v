module acc_spi_i_M (clk , rst , i, rst_i, inc_i , z);
  input clk;
  input rst;
  input rst_i;
  input inc_i;
  output reg z;
  output reg [2:0] i;

always @(negedge clk) begin
  if (rst) begin
   z <= 0;
   i <= 0;
  end else begin
      if (rst_i)
        i <= 0;
        z <= 0;
      if (inc_i)
        i <= i + 1;  
      if (i == 3)
          z <= 1;
  end
end
endmodule