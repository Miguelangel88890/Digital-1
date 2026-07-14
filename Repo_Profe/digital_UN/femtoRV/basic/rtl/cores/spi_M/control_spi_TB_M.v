`timescale 1ns / 1ps
`define SIMULATION

module control_spi_TB_M;
    reg clk;
    reg rst;
    reg init_spi;
    reg c;
    reg z;
    //Estos son las señales de salida del bloque de control:
    wire rst_i;
    wire inc_i;
    wire reset;
    wire sh;
    //registros que se deben modificar
    wire clk_spi;
    wire cs_spi;
    wire done_spi;

    control_spi_M uut( .clk(clk) , .rst(rst) , .init_spi(init_spi) , .c(c) , .z(z) , .rst_i(rst_i) , .inc_i(inc_i) , .reset(reset) , .sh(sh) , .clk_spi(clk_spi) , .cs_spi(cs_spi) , .done_spi(done_spi));

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
        #0 rst = 1; z = 0; c = 0; init_spi = 0;
        @ (negedge clk);
        rst = 0;
        @ (negedge clk);
        init_spi = 1;
        @ (negedge clk);
        init_spi = 0;
        repeat (4) @ (negedge clk);
        z = 1;
        @ (negedge clk);
        z= 0;
        @ (negedge clk);
        repeat (2) @ (negedge clk);
        z = 1;
        @ (negedge clk);
        z = 0;
//      SEND ONE
        repeat (5) @ (negedge clk);
        z = 1;
        @ (negedge clk);
        z= 0;
        @ (negedge clk);
        repeat (4) @ (negedge clk);
        z = 1;
        @ (negedge clk);
        z = 0;
        c = 1;
        repeat (20) @ (negedge clk);
        
   end

   initial begin: TEST_CASE
     $dumpfile("control_spi_TB_M.vcd");
     $dumpvars(-1, uut);
     #(20000) $finish;
   end

endmodule