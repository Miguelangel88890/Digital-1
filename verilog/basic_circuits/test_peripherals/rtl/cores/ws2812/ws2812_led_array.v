module ws2812_led_array (
    input    reset,
    input    clk,
    input    init_m,
    input    rst_cmd,
    input    [15:0]A,
    output reg   [31:0]pp,
    output   dout,
    output   done
);

parameter N_LEDS = 9'd256;

wire init_led;
wire rst_addr;
wire inc_addr;
wire done_led;
wire z;
wire [9:0] address;
wire [23:0] rgb;
// always @(*) begin
//     pp = {16'b0, A[15:0]};
// end
wire [9:0] address_RES;
assign address_RES = address[9:0] - 128;

led_mem     mem0    ( .clk(clk), .address(address), .data_r(rgb) , .A(A) , .ld_left(address_RES[9]) );
ws2812_led  ws2812_0( .clk(clk), .reset(reset), .rgb(rgb), .init(init_led), .rst_cmd(1'b0), .dout(dout), .done(done_led) );
count_addr_arr  count0  ( .clk(clk), .rst(rst_addr), .inc(inc_addr), .address(address) );
ctrl_ws_arr ctrl0   ( .clk(clk), .reset(reset), .init_m(init_m), .done_led(done_led), .z(z), .done(done), .init_led(init_led), .rst(rst_addr), .inc(inc_addr) );
comp_ws_arr comp0   ( .address(address), .N_LEDS(N_LEDS), .z(z) );
//24'hFF0000 azul
//24'hFFFFFF verde
//24'h110022 Rojo
endmodule