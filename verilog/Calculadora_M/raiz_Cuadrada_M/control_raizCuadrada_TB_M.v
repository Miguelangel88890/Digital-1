`timescale 1ns / 1ps
`define SIMULATION

module control_raizCuadrada_TB_M;

 reg clk;
 reg rst;
 reg init;
 reg [31:0]A;

 reg w_C;
 reg w_MSB;


 wire w_reset;
 wire w_sh;
 wire w_set;
 wire w_ld;
 wire done;
 wire [31:0]result;

 control_raizCuadrada_M uut(.clk(clk) , .rst(rst) , .init(init) , .c(w_C) , .msb(w_MSB)  , .reset(w_reset) , .sh(w_sh) , .set(w_set) , .ld(w_ld) , .done(w_done)  );
   
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
      w_C = 1; w_MSB = 1; rst = 1; init = 0; A = 32'b00000000000000000000000000101100; ;
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
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        rst = 1;
        

       end

   initial begin: TEST_CASE
     $dumpfile("control_raizCuadrada_TB_M.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule