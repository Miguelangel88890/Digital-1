module count_addr_arr (
    input             clk,
    input             rst,
    input             inc,
    output reg [9:0] address
);

always @(negedge clk ) begin
    if(rst)
      address <= 0;
    else if (inc)
      address <= address + 1;
    else
      address <= address;
end

endmodule
