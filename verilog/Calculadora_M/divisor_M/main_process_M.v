module main_process_M(clk , rst , temp , in_A , s_A , sh , ld_temp);
  input clk;
  input rst;

  input [15:0] temp;
  input [15:0] in_A;
  output reg [31:0] s_A;
  
  input sh;
  input ld_temp;

  always @(negedge clk) begin
    if (rst) begin
        s_A <= {16'b0 , in_A};
    end
    else begin
        if (ld_temp) begin
            s_A[31:0] <= {temp[15:0],s_A[15:1],1'b1};
        end
        else begin
            if (sh)
              s_A[31:0] <= {s_A[30:0], 1'b0};
            else 
              s_A <= s_A;
        end
    end
end

endmodule

