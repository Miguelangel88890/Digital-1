`timescale 1ns / 1ps
`define SIMULATION

module load_temp_M_TB;

   reg clk;
   reg rst;
   wire [31:0]A;
   wire [15:0]temp;
   reg [15:0]resta_temp;
   reg z;

   load_temp_M uut(.clk(clk) , .ld_temp_lsbA(z) , .A(A) , .temp(temp) , .resta_temp(resta_temp) , .rst(rst));

   parameter PERIOD          = 20;
   parameter real DUTY_CYCLE = 0.5;
   parameter OFFSET          = 0;

   initial  begin  // Process for clk
     #OFFSET;
     forever
       begin
         clk = 1'b0;
         #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
         #(PERIOD*DUTY_CYCLE);
       end
   end

   initial begin  // Initialize Inputs
      resta_temp = 16'd15 ; z = 0; rst = 1;
   end

   reg [2:0] i;
   initial begin // Reset the system, Start the image capture process
        
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @ (posedge clk);
        @ (negedge clk);
        z = 1;
       for(i=0; i<4; i=i+1) begin
         @ (posedge clk);
       end
   end

   initial begin: TEST_CASE
     $dumpfile("load_temp_TB_M.vcd");
     $dumpvars(-1, uut);
     #(120) $finish;
   end
endmodule
