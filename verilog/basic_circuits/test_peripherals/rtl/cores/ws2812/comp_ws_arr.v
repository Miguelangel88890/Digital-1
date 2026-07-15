module comp_ws_arr (
    input [9:0] address,
    input [9:0] N_LEDS,
    output reg   z
);

always @(*) begin
    if(address == N_LEDS)
        z <= 1;
    else
        z <= 0;
end

endmodule