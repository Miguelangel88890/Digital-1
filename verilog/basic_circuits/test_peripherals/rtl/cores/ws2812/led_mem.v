module led_mem(
   input             clk,
   input      [9:0]  address,
   output reg [23:0] data_r,
   input [15:0]A,
   input ld_left
);
    // reg [23:0] MEM_test [0:255];
    reg [23:0] MEM_num_1 [0:127];
    reg [23:0] MEM_num_0 [0:127];
    reg [23:0] MEM_num_2 [0:127];
    reg [23:0] MEM_num_3 [0:127];
    reg [23:0] MEM_num_4 [0:127];
    reg [23:0] MEM_num_5 [0:127];
    reg [23:0] MEM_num_6 [0:127];
    reg [23:0] MEM_num_7 [0:127];
    reg [23:0] MEM_num_8 [0:127];
    reg [23:0] MEM_num_9 [0:127];
    reg [23:0] MEM2 [0:255];
    reg [23:0] MEM3 [0:255];
    initial begin
        // $readmemh("./display_test.hex",  MEM_test);
        $readmemh("./display_num_0.hex",  MEM_num_0);
        $readmemh("./display_num_1.hex",  MEM_num_1);
        $readmemh("./display_num_2.hex",  MEM_num_2);
        $readmemh("./display_num_3.hex",  MEM_num_3);
        $readmemh("./display_num_4.hex",  MEM_num_4);
        $readmemh("./display_num_5.hex",  MEM_num_5);
        $readmemh("./display_num_6.hex",  MEM_num_6);
        $readmemh("./display_num_7.hex",  MEM_num_7);
        $readmemh("./display_num_8.hex",  MEM_num_8);
        $readmemh("./display_num_9.hex",  MEM_num_9);
        $readmemh("./display2.hex", MEM2);
        $readmemh("./display3.hex", MEM3);
    end

    always @(negedge clk) begin
        if(ld_left)begin
            case (A[5:4])
                2'b00: begin
                        data_r <= MEM_num_0[address];
                end
                2'b01: begin
                        data_r <= MEM_num_1[address];
                end
                2'b10: begin
                        data_r <= MEM_num_2[address];
                end
                2'b11: begin
                        data_r <= MEM_num_3[address];
                end
                default: data_r <= MEM3[address];
            endcase
        end
        else begin
            case (A[3:0])
                4'b0000: begin
                        data_r <= MEM_num_0[address-128];
                end
                4'b0001: begin
                        data_r <= MEM_num_1[address-128];
                end
                4'b0010: begin
                        data_r <= MEM_num_2[address-128];
                end
                4'b0011: begin
                        data_r <= MEM_num_3[address-128];
                end
                4'b0100: begin
                        data_r <= MEM_num_4[address-128];
                end
                4'b0101: begin
                        data_r <= MEM_num_5[address-128];
                end
                4'b0110: begin
                        data_r <= MEM_num_6[address-128];
                end
                4'b0111: begin
                        data_r <= MEM_num_7[address-128];
                end
                4'b1000: begin
                        data_r <= MEM_num_8[address-128];
                end
                4'b1001: begin
                        data_r <= MEM_num_9[address-128];
                end
                default: data_r <= MEM2[address];
            endcase
        end
        
        
        // if (address > 128)
        //     data_r <= MEM_num_0[address - 128];
    end

endmodule
