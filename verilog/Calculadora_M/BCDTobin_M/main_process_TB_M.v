`timescale 1ns / 1ps
`define SIMULATION

module main_process_M_TB;

  reg clk;
  reg rst;

  reg [3:0] in_A;
  reg [3:0] in_B;
  reg [3:0] A1;
  reg [3:0] A2;
  reg [3:0] A3;
  wire [31:0] s_A;
  
  reg sh;
  reg ld1;
  reg ld2;
  reg ld3;

   main_process_M uut(.clk(clk) , .rst(rst) , .in_A(in_A) , .in_B(in_B) , .A1(A1) , .A2(A2) , .A3(A3) , .s_A(s_A) , .sh(sh) , .ld1(ld1) , .ld2(ld2) , .ld3(ld3));

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
      A1 = 4'd1; A2 = 4'd2; A3 = 4'd3; in_A = 8'd4; in_B = 8'd3; sh = 0; ld1 = 0; ld2 = 0; ld3 = 0; rst = 1;
   end

   reg [2:0] i;
   initial begin // Reset the system, Start the image capture process
        
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @ (posedge clk);
        @ (negedge clk);
        ld1 = 1;
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        ld2 = 1;
        ld3 = 1;
        @ (posedge clk);
        @ (negedge clk);
        ld1 = 0;
        ld2 = 0;
        ld3 = 0;
        sh = 1;
       for(i=0; i<4; i=i+1) begin
         @ (posedge clk);
       end
   end

   initial begin: TEST_CASE
     $dumpfile("main_process_TB_M.vcd");
     $dumpvars(-1, uut);
     #(500) $finish;
   end
endmodule
