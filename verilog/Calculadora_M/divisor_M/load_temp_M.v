module load_temp_M(clk , ld_temp_lsbA, A , temp , resta_temp , rst);
  input clk;
  input rst;
  input ld_temp_lsbA;
  input [15:0]resta_temp;
  output reg [31:0]A;
  output reg [15:0]temp;

  always @(negedge clk) begin
    if (rst) begin
        A    <= 32'd10;
        temp <= 16'd10;
    end
    else begin
        if (ld_temp_lsbA) begin
            temp <= resta_temp;
            A[0] <= 1;
        end
        else begin
            temp <= temp;
        end
    end
end

endmodule

