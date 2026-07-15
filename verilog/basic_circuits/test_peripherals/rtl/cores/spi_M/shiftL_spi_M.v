module shiftL_spi_M(clk , rst , in_SO , s_A ,  sh );
  input clk;
  input rst;

  input in_SO;
  output reg [15:0] s_A;
  
  input sh;
  

  always @(negedge clk) begin
    if (rst) begin
        s_A <= 16'b0;
    end
    else begin
        if (sh) begin
            s_A[15:0] <= {s_A[14:0],in_SO};
        end
        else begin
            s_A <= s_A;
        end
    end
end

endmodule