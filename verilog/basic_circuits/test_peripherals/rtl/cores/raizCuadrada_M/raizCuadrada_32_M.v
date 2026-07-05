module raizCuadrada_32_M(clk, rst, init, done, A, pp);
    input rst;
    input clk;
    input init;
    input [31:0]A;
    output [31:0]pp;
    output done;


    wire w_sh;
    wire w_ld;
    wire w_set;
    wire w_reset;
    wire w_done;

    wire w_C;

    wire [31:0]w_A;

    reg [5:0] i;
    wire [31:0] aux;
    wire [15:0] in_RES;
    assign in_RES = w_A[31:16] + (~((aux<<1) + 1) + 1);

    


    acc_raiz_M acc_M0 (.clk(clk) , .i(i), .sh(w_sh), .rst(w_reset) , .c(w_C));

    write_result_raiz_M write_result_raiz_M0 (.clk(clk) , .sh(w_sh) , .ld(w_ld) , .rst(w_reset) , .result(pp));

    aux_M aux_M0 (.clk(clk) , .set(w_set) , .rst(w_reset) , .in_rta(pp) , .s_aux(aux));

    shiftL_32_raiz_M shiftL_32_raiz_M0 (.clk(clk) , .in_A(A) , .in_RES(in_RES) , .s_A(w_A) , .ld(w_ld) , .sh(w_sh) , .rst(w_reset));

    control_raizCuadrada_M estados_M0 ( .clk(clk) , .rst(rst) , .init(init) , .c(w_C) , .msb(in_RES[15])  , .reset(w_reset) , .sh(w_sh) , .set(w_set) , .ld(w_ld) , .done(w_done) );

endmodule