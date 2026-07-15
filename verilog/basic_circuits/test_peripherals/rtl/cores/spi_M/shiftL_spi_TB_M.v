`timescale 1ns / 1ps
`define SIMULATION

module shiftL_spi_TB_M;

  reg clk;
  reg rst;

  reg in_SO;
  wire [15:0] s_A;
  
  reg sh;

   shiftL_spi_M uut(.clk(clk) , .rst(rst) , .in_SO(in_SO) , .s_A(s_A) ,  .sh(sh) );

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
      in_SO= 0 ;sh = 0; rst = 1;
   end

   reg [2:0] i;
   initial begin // Reset the system, Start the image capture process
        
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @ (posedge clk);
        sh = 1;
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        in_SO = 1;
        @ (posedge clk);
        @ (negedge clk);
        in_SO = 0;
        
       for(i=0; i<20; i=i+1) begin
         @ (posedge clk);
       end
   end

   initial begin: TEST_CASE
     $dumpfile("shiftL_spi_TB_M.vcd");
     $dumpvars(-1, uut);
     #(120) $finish;
   end
endmodule