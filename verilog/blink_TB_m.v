`timescale 1ns / 1ps
`define SIMULATION

module blink_TB_m;

   reg clk = 0;
   reg rst;
   wire led;

   blink_m uut( .clk(clk) , .rst(rst) , .led(led) );

   parameter PERIOD = 20;

   always #(PERIOD/2) clk = ~clk;

   initial begin
      rst = 1;
      #50;
      rst = 0;
   end

   initial begin
     $dumpfile("blink_TB_m.vcd");
     $dumpvars(0, blink_TB_m);
     #1000 $finish;
   end

endmodule