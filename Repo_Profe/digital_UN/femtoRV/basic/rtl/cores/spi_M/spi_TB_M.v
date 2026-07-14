`timescale 1ns / 1ps
`define SIMULATION

module spi_TB_M;

    reg clk;
    reg rst;
    reg init_spi;
    reg SO;
    

    spi_M uut( .clk(clk), .rst(rst), .init_spi(init_spi), .SO(SO) );

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

    initial begin
        #0 rst = 1; init_spi = 0; SO = 0;
        @ (negedge clk);
        rst  = 0;
        @ (negedge clk);
        init_spi = 1;
        @ (negedge clk);
        init_spi = 0;
        @ (negedge clk);
        SO = 1;
    end


    initial begin: TEST_CASE
        $dumpfile("spi_TB_M.vcd");
        $dumpvars(-1, uut);
        #(100000) $finish;
    end

endmodule