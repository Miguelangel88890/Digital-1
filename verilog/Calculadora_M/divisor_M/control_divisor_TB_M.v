`timescale 1ns / 1ps
`define SIMULATION

module control_divisor_TB_M;

 reg clk;
 reg rst;
 reg init;
 reg [31:0]A;
 reg [15:0]B;

 reg w_C;
 reg w_MSB;

 wire w_ld_temp_lsbA;
 wire w_addi;
 wire done;
 wire [31:0]result;

 control_divisor_M estados_divisor_M0 (.clk(clk) , .rst(rst) , .init(init) .ld_temp_lsbA(w_ld_temp_lsbA) , .addi(w_addi) .c(W_C) , .done(done) , .msb(w_MSB) , .reset(rst));
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
      w_C = 0; w_MSB = 0; rst = 1; init = 0; B = 16'b0000000000010111; A = 32'b00000000000000000000000000101100; ;
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
     $dumpfile("divisor_32_TB_M.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule