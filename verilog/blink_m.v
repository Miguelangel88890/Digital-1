module blink_m (clk , rst, led);
  input clk;
  input rst;
  output led; 
  
  reg [26:0]frecuencia;

  assign led = ~frecuencia[23];

always @(posedge clk)begin
    if (~rst) 
            frecuencia <= 26'b0000;
    else
            frecuencia <= frecuencia + 1;
end
endmodule