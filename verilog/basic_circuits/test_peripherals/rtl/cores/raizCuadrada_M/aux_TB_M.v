`timescale 1ns / 1ps
`define SIMULATION

module aux_TB_M;

   reg clk;
   reg sh; 
   reg rst;

   reg [31:0] in_rta;
   wire [31:0] s_aux;

   aux_M uut(.clk(clk) , .sh(sh) , .rst(rst) , .in_rta(in_rta) , .s_aux(s_aux));

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
      rst = 0; sh = 0; in_rta = 32'd20;
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
     $dumpfile("aux_TB_M.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule