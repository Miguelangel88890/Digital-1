`timescale 1ns / 1ps
`define SIMULATION

module load_temp_M_TB;

   reg [15:0] A;
   reg [15:0] temp;
   reg z;

   load_temp_M uut(.ld_temp(z) , .A(A) , .temp(temp));

   initial begin  // Initialize Inputs
      A <= 16'd21 ; temp <= 16'd10; z = 0;
   end

   initial begin // Reset the system, Start the image capture process

   end

   initial begin: TEST_CASE
     $dumpfile("load_temp_TB_M.vcd");
     $dumpvars(-1, uut);
     #(120) $finish;
   end
endmodule
