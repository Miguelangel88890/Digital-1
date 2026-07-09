module main_process_M(clk , rst , in_A , in_B , A1 , A2 , A3 , s_A , sh , ld1 , ld2 , ld3);
  input clk;
  input rst;

  input [3:0] in_A;
  input [3:0] in_B;
  input [3:0] A1;
  input [3:0] A2;
  input [3:0] A3;
  output reg [31:0] s_A;
  
  input sh;
  input ld1;
  input ld2;
  input ld3;

  always @(negedge clk) begin
    if (rst) begin
        s_A <= {16'b0 , in_A , in_B , 8'b0};
    end
    else begin
        if (ld1) begin
            s_A[11:8] <= A1;
        end
        if (ld2) begin
            s_A[15:12] <= A2;
        end
        if (ld3) begin
            s_A[19:16] <= A3;
        end
        if (sh) begin
            s_A[31:0] <= {1'b0 , s_A[31:1]};
        end
    end
end

endmodule

