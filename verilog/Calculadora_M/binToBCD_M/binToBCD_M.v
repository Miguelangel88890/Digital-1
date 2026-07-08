module binToBCD_M(clk, rst, init, done, A, pp);
    input rst;
    input clk;
    input init;
    input [7:0]A;
    output [15:0]pp;
    output done;

    wire w_sh;
    wire w_ld1;
    wire w_ld2;
    wire w_ld3;
    wire w_reset;

    wire w_C;

    wire [31:0]w_A;

    reg [5:0] i;
    wire [3:0] temp_SUM1;
    wire [3:0] temp_SUM2;
    wire [3:0] temp_SUM3;
    wire [3:0] temp_RES1;
    wire [3:0] temp_RES2;
    wire [3:0] temp_RES3;

    assign temp_SUM1 = w_A[11:8] + 3;
    assign temp_SUM2 = w_A[15:12] + 3;
    assign temp_SUM3 = w_A[19:16] + 3;

    assign temp_RES1 = w_A[11:8] + (~4'b0101 + 1);
    assign temp_RES2 = w_A[15:12] + (~4'b0101 + 1);
    assign temp_RES3 = w_A[19:16] + (~4'b0101 + 1);

    assign pp = {4'b0 , w_A[19:16] , w_A[15:12] , w_A[11:8]};
    


    acc_M acc_M0 (.clk(clk), .i(i) , .addi(w_sh) , .rst(w_reset) , .c(w_C));

    main_process_M main_process_M0 (.clk(clk) , .rst(rst) , .in_A(A) , .A1(temp_SUM1) , .A2(temp_SUM2) , .A3(temp_SUM3) , .s_A(w_A) , .sh(w_sh) , .ld1(w_ld1) , .ld2(w_ld2) , .ld3(w_ld3));

    control_binToBCD_M estados_binToBCD_M0 ( .clk(clk) , .rst(rst) , .init(init) , .c(w_C) , .msb1(temp_RES1[3]) , .msb2(temp_RES2[3]) , .msb3(temp_RES3[3]) , .reset(w_reset) , .sh(w_sh) , .ld1(w_ld1) , .ld2(w_ld2) , .ld3(w_ld3)  , .done(done) );

endmodule