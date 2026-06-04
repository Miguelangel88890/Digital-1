module resta_M(temp, B, result);
  input [15:0]B;
  input [15:0]temp;
  output reg [15:0]result;

  always@(*) begin
      result <= temp + ( ~B + 1);
  end
    

endmodule