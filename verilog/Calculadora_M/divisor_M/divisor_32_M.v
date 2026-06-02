module divisor_32_M(clk, rst, init, done, A, B, pp);
    input rst;
    input clk;
    input init;
    input [15:0]A;
    input [15:0]B;
    output [15:0]pp;
    output done;

    //Aqui depronto falta el A_LSB, que deberia hacer el bit menos significativo de A igual a 1
    wire w_sh;
    wire w_ld_temp;
    wire w_reset;
    wire w_addi;

    wire w_C;

    wire [31:0]w_A;

    reg [5:0] i;
    wire [15:0] temp;
    assign temp = w_A[31:16] + (~B + 1);

    assign pp = w_A[15:0];
    


    acc_M acc_M0 (.clk(clk), .i(i) , .addi(w_addi) , .rst(w_reset) , .c(w_C));

    main_process_M main_process_M0 (.clk(clk) , .rst(w_reset) , .temp(temp) , .in_A(A) , .s_A(w_A) , .sh(w_sh) , .ld_temp(w_ld_temp));

    control_divisor_M estados_divisor_M0 (.clk(clk) , .rst(rst) , .init(init) , .c(w_C) , .msb(temp[15])  , .reset(w_reset) , .sh(w_sh) , .addi(w_addi) , .ld_temp(w_ld_temp)  , .done(done) );

endmodule