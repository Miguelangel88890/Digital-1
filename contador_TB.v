`timescale 1ns / 1ps
`define SIMULATION

module contador_TB;

   reg clk;
   reg count;
   reg rst;
   wire [31:0]A;

   contador uut( .clk(clk) , .A(A) , .count(count) , .rst(rst)  );

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
      rst = 0; count = 0; 
   end

   reg [2:0] i;
   initial begin // Reset the system, Start the image capture process
        #20 rst = 1;
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @ (posedge clk);
        @ (negedge clk);
        count = 1;
       for(i=0; i<10; i=i+1) begin
         @ (posedge clk);
       end
   end


   initial begin: TEST_CASE
     $dumpfile("contador_TB.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule