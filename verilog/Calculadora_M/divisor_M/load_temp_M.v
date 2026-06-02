module load_temp_M(clk , ld_temp_lsbA, A_LSB, A , sh, temp , rst);
  input clk;
  input rst;
  input sh;
  input A_LSB;
  input ld_temp_lsbA;
  input [31:0] A;
  output reg [31:0]temp;

  always @(negedge clk) begin
    if (rst) begin
        temp    <= A;
    end
    else begin
        if (ld_temp_lsbA) begin
            temp[31:16] <= A [31:16];
        end
        else begin
            if (sh)
              temp[31:0] <= {temp[30:1], A_LSB};
            else 
              temp <= temp;
        end
    end
end

endmodule

