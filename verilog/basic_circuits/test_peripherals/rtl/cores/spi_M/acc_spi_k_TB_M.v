`timescale 1ns / 1ps
`define SIMULATION

module acc_spi_k_TB_M;

   reg clk;
   reg rst;
   reg inc_k;
   wire w_W;
   wire [7:0]k;

   acc_spi_k_M uut( .clk(clk) , .rst(rst) , .k(k) , .inc_k(inc_k) , .w(w_W));

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
      rst = 0; inc_k = 0;  
   end

   reg [3:0] l;
   initial begin // Reset the system, Start the image capture process
        #20 rst = 1;
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        inc_k = 1;

       for(l=0; l<10; l=l+1) begin
         @ (posedge clk);
       end
   end


   initial begin: TEST_CASE
     $dumpfile("acc_spi_k_TB_M.vcd");
     $dumpvars(-1, uut);
     #(10000) $finish;
   end
endmodule