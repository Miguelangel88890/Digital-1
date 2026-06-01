module divisor_32_M(clk, rst, init, done, A, B, pp);
    input rst;
    input clk;
    input init;
    input [31:0]A;
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
    assign w_temp <= A{31:16};
    assign resta_temp_B <= temp + (~B + 1);
    


    shiftL_32_M shL_M1  (.clk(clk) , .sh(w_sh) , .rst(w_reset) , .in_A(A) , .s_A(w_A));

    acc_M acc_M0 (.clk(clk), .i(i) , .addi(w_addi) , .rst(w_reset) , .c(W_C));

    load_temp__M load_temp_M0 (.clk(clk) , .ld_temp_lsbA(w_ld_temp_lsbA) , .A(w_A) , .temp(w_temp) , .resta_temp(resta_temp_B));
    
    control_divisor_M estados_divisor_M0 (.clk(clk) , .rst(rst) , .init(init) .ld_temp_lsbA(w_ld_temp_lsbA) , .addi(w_addi) .c(W_C) , .done(done) , .msb(resta_temp_B[15]) , .reset(rst));

endmodule