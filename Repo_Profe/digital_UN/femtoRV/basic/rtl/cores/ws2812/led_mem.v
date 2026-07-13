module led_mem(
   input             clk,
   input      [9:0]  address,
   output reg [23:0] data_r
);
    reg [23:0] MEM [0:255];
    initial begin
        $readmemh("./display.hex",MEM);
    end

    always @(negedge clk) begin
        data_r <= MEM[address];
    end

endmodule
