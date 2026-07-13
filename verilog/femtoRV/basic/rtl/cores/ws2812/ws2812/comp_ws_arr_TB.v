`timescale 1ns / 1ps
`define SIMULATION

module comp_ws_arr_TB;

 reg [5:0] address;
 reg [5:0] n_leds;


    comp_ws_arr uut( .address(address), .N_LEDS(n_leds) );

    initial  begin
        #0 address = 20; n_leds = 30;

        # 40 address = 30; n_leds = 30;
        # 40 address = 50; n_leds = 30;
        # 40 address = 20; n_leds = 20;
        # 40 address = 29; n_leds = 30;
    end

    initial begin: TEST_CASE
        $dumpfile("comp_ws_arr_TB.vcd");
        $dumpvars(-1, uut);
        #(100000) $finish;
    end

endmodule
