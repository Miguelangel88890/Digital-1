`timescale 1ns / 1ps
`define SIMULATION

module acc_spi_j_TB_M;

   reg clk;
   reg rst;
   reg sh;
   wire w_C;
   wire [4:0]j;

   acc_spi_j_M uut( .clk(clk) , .rst(rst) , .j(j) , .sh(sh) , .c(w_C));

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
      rst = 0; sh = 0;  
   end

   reg [3:0] k;
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
        sh = 1;

       for(k=0; k<10; k=k+1) begin
         @ (posedge clk);
       end
   end


   initial begin: TEST_CASE
     $dumpfile("acc_spi_j_TB_M.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule