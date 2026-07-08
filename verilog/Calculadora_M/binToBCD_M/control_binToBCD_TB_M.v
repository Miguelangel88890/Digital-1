`timescale 1ns / 1ps
`define SIMULATION

module control_binToBCD_TB_M;

 reg clk;
 reg rst;
 reg init;

 reg w_C;
 reg w_msb1;
 reg w_msb2;
 reg w_msb3;


 wire w_reset;
 wire w_sh;
 wire w_ld1;
 wire w_ld2;
 wire w_ld3;
 wire done;

 control_binToBCD_M uut( .clk(clk) , .rst(rst) , .init(init) , .c(w_C) , .msb1(w_msb1) , .msb2(w_msb2) , .msb3(w_msb3) , .reset(w_reset) , .sh(w_sh) , .ld1(w_ld1) , .ld2(w_ld2) , .ld3(w_ld3)  , .done(done) );
   
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
      w_C = 0; w_msb1 = 0; w_msb2 = 0; w_msb3 = 0; rst = 1; init = 0;
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
        @ (posedge clk);
        @ (negedge clk);
        init = 0;
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        
        

       end

   initial begin: TEST_CASE
     $dumpfile("control_binToBCD_TB_M.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule