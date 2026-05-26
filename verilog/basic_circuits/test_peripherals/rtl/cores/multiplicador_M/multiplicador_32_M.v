module multiplicador_32_M(clk, rst, init, done, A, B, pp);
    input rst;
    input clk;
    input init;
    input [31:0]A;
    input [15:0]B;
    output [31:0]pp;
    output done;

    wire w_sh;
    wire w_reset;
    wire w_acc;
    wire w_z;

    wire [31:0]w_A;
    wire [15:0]w_B;
    shiftR_16_M shR_M0  (.clk(clk) , .sh(w_sh) , .rst(w_reset) , .in_B(B) , .s_B(w_B));
    shiftL_32_M shL_M1  (.clk(clk) , .sh(w_sh) , .rst(w_reset) , .in_A(A) , .s_A(w_A));

    comp_M comp_M0 (.B(w_B) , .z(w_z));

    acc_M acc_M0 (.clk(clk), .A(w_A) , .add(w_acc) , .rst(w_reset) , .pp(pp));

    control_mult_M mult_M0 (.clk(clk) , .rst(rst) , .lsb_B(w_B[0]) , .init(init) , .z(w_z) , .done(done) , .sh(w_sh) , .reset(w_reset) , .add(w_acc));

endmodule