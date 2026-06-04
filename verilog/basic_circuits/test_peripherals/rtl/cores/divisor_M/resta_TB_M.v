`timescale 1ns / 1ps
`define SIMULATION

module resta_TB_M;

   reg [15:0] B;
   reg [15:0] temp;

   resta_M uut(.temp(temp) , .B(B));

   initial begin  // Initialize Inputs
      B <= 16'd21 ; temp <= 16'd10;
   end

   initial begin // Reset the system, Start the image capture process

   end

   initial begin: TEST_CASE
     $dumpfile("resta_TB_M.vcd");
     $dumpvars(-1, uut);
     #(120) $finish;
   end
endmodule
