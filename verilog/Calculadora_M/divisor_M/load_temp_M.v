module load_temp__M(ld_temp, A, temp);
  input ld_temp;
  input [31:0]A;
  input temp
  input shift,
  output msb_A
  output reg [15:0]temp;

  always@(*) begin
    if(ld_temp)
      temp <= A[15:0];
  end
    

endmodule