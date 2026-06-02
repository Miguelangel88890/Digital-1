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
    wire w_ld_temp_lsbA;
    wire w_reset;
    wire w_addi;

    wire w_C;

    wire [31:0]w_A;
    wire [15:0]w_temp;

    reg [5:0] i;
    wire [15:0]resta_temp_B;
    assign resta_temp_B = w_temp + (~B + 1);
    


    acc_M acc_M0 (.clk(clk), .i(i) , .addi(w_addi) , .rst(w_reset) , .c(W_C));

    load_temp_M load_temp_M0 (.clk(clk) , .rst(w_reset), , .sh(w_sh), .A_LSB(A_LSB), .ld_temp_lsbA(w_ld_temp_lsbA) , .A({resta_temp_B,A}) , .temp(w_temp) );


    control_divisor_M estados_divisor_M0 (.clk(clk) , .rst(rst) , .init(init) , .c(W_C) , .msb(resta_temp_B[15])  , .reset(w_reset) , .sh(w_sh) , .addi(w_addi) , .ld_temp_lsbA(w_ld_temp_lsbA)  , .done(done) );

endmodule