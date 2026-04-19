module multiplicador_32(clk, rst, init, done, A, B, pp);
    input rst;
    input clk;
    input init;
    input [15:0]A;
    input [15:0]B;
    output[31:0]pp;
    output done;

    wire w_sh;
    wire w_reset;
    wire w_acc;
    wire w_z;

    wire [31:0]w_A;
    wire [15:0]w_B;

    shiftR_16 sh0  (.clk(clk), .in_B(B) , .sh(w_sh) , .load(w_reset) , .s_B(w_B));


endmodule