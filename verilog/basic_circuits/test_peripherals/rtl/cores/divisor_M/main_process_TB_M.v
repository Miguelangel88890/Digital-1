`timescale 1ns / 1ps
`define SIMULATION

module main_process_M_TB;

  reg clk;
  reg rst;

  reg [15:0] temp;
  reg [15:0] in_A;
  wire [31:0] s_A;
  
  reg sh;
  reg ld_temp;

   main_process_M uut(.clk(clk) , .rst(rst) , .temp(temp) , .in_A(in_A) , .s_A(s_A) , .sh(sh) , .ld_temp(ld_temp));

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
      temp = 16'd15; in_A = 16'd20; sh = 0; ld_temp = 0; rst = 1;
   end

   reg [2:0] i;
   initial begin // Reset the system, Start the image capture process
        
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @ (posedge clk);
        @ (negedge clk);
        sh = 1;
        ld_temp = 1;
       for(i=0; i<4; i=i+1) begin
         @ (posedge clk);
       end
   end

   initial begin: TEST_CASE
     $dumpfile("main_process_TB_M.vcd");
     $dumpvars(-1, uut);
     #(120) $finish;
   end
endmodule
