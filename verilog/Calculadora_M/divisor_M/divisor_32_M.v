module divisor_32_M(clk, rst, init, done, A, B, pp);
    input rst;
    input clk;
    input init;
    input [15:0]A;
    input [15:0]B;
    output [31:0]pp;
    output done;

    //Aqui depronto falta el A_LSB, que deberia hacer el bit menos significativo de A igual a 1
    wire w_sh;
    wire w_ld_rt;
    wire w_ld_temp;
    wire w_reset;
    wire w_addi;

    wire w_MSB;
    wire w_C;

    wire [15:0]w_A;
    wire [15:0]w_B;
    shiftR_32_M shR_M0  (.clk(clk) , .sh(w_sh) , .rst(w_reset) , .in_B(B) , .s_B(w_B));
    shiftL_32_M shL_M1  (.clk(clk) , .sh(w_sh) , .rst(w_reset) , .in_A(A) , .s_A(w_A));

    comp_M comp_M0 (.B(w_B) , .z(w_z));

    acc_M acc_M0 (.clk(clk), .A(w_A) , .add(w_acc) , .rst(w_reset) , .pp(pp));

    control_divisor_M estados_divisor_M0 (.clk(clk) , .rst(rst) , .lsb_B(w_B[0]) , .init(init) , .z(w_z) , .done(done) , .sh(w_sh) , .reset(w_reset) , .add(w_acc));

endmodule