`timescale 1ns / 1ps
`define SIMULATION

module acc_spi_i_TB_M;

   reg clk;
   reg rst;
   reg rst_i;
   reg inc_i;
   wire w_Z;
   wire [2:0]i;

   acc_spi_i_M uut( .clk(clk) , .rst(rst) , .i(i), .rst_i(rst_i), .inc_i(inc_i) , .z(w_Z));

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
      rst = 0; rst_i = 0; inc_i=0;  
   end

   reg [3:0] k;
   initial begin // Reset the system, Start the image capture process
        #20 rst = 1;
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @ (posedge clk);
        @ (negedge clk);
        inc_i = 1;
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        rst_i = 1;
        inc_i = 0;
        @ (posedge clk);
        @ (negedge clk);
        rst_i = 0;
        inc_i = 1;
       for(k=0; k<10; k=k+1) begin
         @ (posedge clk);
       end
   end


   initial begin: TEST_CASE
     $dumpfile("acc_spi_i_TB_M.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule