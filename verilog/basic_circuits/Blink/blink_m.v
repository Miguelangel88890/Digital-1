module blink_m (clk , rst, led);
  input clk;
  input rst;
  output led;
  output txd;

  reg [25:0] frecuencia;

  assign led = frecuencia[25];

always @(negedge clk)
    if (~rst) 
        begin
            frecuencia <= 0;
        end
    else
        begin
            frecuencia <= frecuencia + 1;
        end
    
endmodule