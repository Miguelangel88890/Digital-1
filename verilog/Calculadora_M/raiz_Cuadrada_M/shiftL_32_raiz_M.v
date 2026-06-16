module shiftL_32_raiz_M(clk , in_A , in_RES , s_A , ld , sh , rst);
  input clk;
  input rst;

  input [15:0] in_RES;
  input [31:0] in_A;
  output reg [31:0] s_A;
  
  input sh;
  input ld;

  always @(negedge clk) begin
    if (rst) begin
        s_A <= in_A;
    end
    else begin
        if (sh) begin
            s_A[31:0] <= {s_A[30:0],1'b0};
        end
        else begin
            if (ld)
              s_A[31:16] <= in_RES[15:0];
            else 
              s_A <= s_A;
        end
    end
end

endmodule