`timescale 1ns / 1ps
`define SIMULATION

module multiplicador_32_TB;

 reg clk;
 reg rst;
 reg init;
 reg [31:0]A;
 reg [15:0]B;

 wire done;
 wire [31:0]result;

 multiplicador_32 uut( .clk(clk), .rst(rst), .init(init), .done(done) , .A(A) , .B(B) , .pp(result) );

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

   initial begin // Reset the system, Start the image capture process
      rst = 1;init = 0; B = 16'b0000000000010111; A = 32'b00000000000000000000000000101100; ;
   end


   reg [2:0] i;
   initial begin // Reset the system, Start the image capture process
        @ (posedge clk);
        @ (negedge clk);
        init = 1;
        rst = 1;
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @(posedge clk);
        @ (posedge clk);
        @ (negedge clk);
        

       end

   initial begin: TEST_CASE
     $dumpfile("multiplicador_32_TB.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule