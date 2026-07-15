module spi_M (
    input  rst,
    input  clk,
    input  init_spi,
    input  SO,
    output cs_spi,
    output clk_spi,
    output [31:0]pp,
    output done_spi
);

wire w_reset;
wire [5:0]w_i;
wire w_rst_i;
wire w_inc_i;
wire w_z;
wire [4:0]w_j;
wire w_sh;
wire w_c;
wire [7:0]w_k;
wire w_w;
wire w_inc_k;
wire [15:0]w_A;


assign pp = {22'b0, w_A[14:5]};


acc_spi_i_M acc_spi_i_0 (.clk(clk) , .rst(w_reset) , .i(w_i) , .rst_i(w_rst_i) , .inc_i(w_inc_i) , .z(w_z));

acc_spi_j_M acc_spi_j_0 (.clk(clk) , .rst(w_reset) , .j(w_j) , .sh(w_sh) , .c(w_c));

acc_spi_k_M acc_spi_k_0 (.clk(clk) , .rst(w_reset) , .k(w_k) , .inc_k(w_inc_k) , .w(w_w));

shiftL_spi_M shiftL_spi_0 (.clk(clk) , .rst(w_reset) , .in_SO(SO) , .s_A(w_A) ,  .sh(w_sh));

control_spi_M control_spi_0 (.clk(clk) , .rst(rst) , .init_spi(init_spi) , .c(w_c) , .z(w_z) , .w(w_w) ,
                    .rst_i(w_rst_i) , .inc_i(w_inc_i) , .reset(w_reset) , .sh(w_sh) , .inc_k(w_inc_k) , .clk_spi(clk_spi) , .cs_spi(cs_spi) , .done_spi(done_spi));


endmodule