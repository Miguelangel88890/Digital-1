module aux_M (clk , sh , rst , in_rta , s_aux);
  input clk;
  input rst;
  input sh;

  input [31:0] in_rta;
  output reg [31:0] s_aux;

always @(negedge clk) begin
  if (rst) begin
   s_aux <= 32'b0;
  end else begin
      if (sh)
        s_aux <= in_rta;
      else 
          s_aux <= s_aux;
  end
end
endmodule


