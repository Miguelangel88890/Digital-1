module control_spi_M (
    input clk,
    input rst,
    input init_spi,  
    // Estos son las señales entrada del Bloque de control:
    input c,
    input z,
    input w,
    //Estos son las señales de salida del bloque de control:
    output reg rst_i,
    output reg inc_i,
    output reg reset,
    output reg sh,
    output reg inc_k,
    //registros que se deben modificar
    output reg clk_spi,
    output reg cs_spi,
    output reg done_spi
);


 parameter START     = 4'b0000;
 parameter CS_LOW   = 4'b0001;
 parameter WAIT_K  = 4'b0010;
 parameter RESETEO_I    = 4'b0011;
 parameter WAIT_HIGH    = 4'b0100;
 parameter SHIFT = 4'b0101;
 parameter WAIT_LOW   = 4'b0110;
 parameter CHECK_NBITS  = 4'b0111;
 parameter CS_HIGH    = 4'b1000;
 parameter END  = 4'b1001;

reg [3:0] state;
reg [22:0] count1;
reg [4:0] count2;

always @(posedge clk ) begin
    if (rst) begin
        state = START;
    end else begin
        case (state)
            START:
                if(init_spi)begin
                    state = CS_LOW;
                    count1 <= 0;
                    count2 <= 0;
                end
                else begin
                    state = START;
                end
            CS_LOW:
                state = WAIT_K;
            WAIT_K:
                if(w)
                    state = RESETEO_I;
                else
                    state = WAIT_K;
            RESETEO_I:
                state = WAIT_HIGH;
            WAIT_HIGH:
                if(z)
                    state = SHIFT;
                else
                    state = WAIT_HIGH;
            SHIFT:
                state = WAIT_LOW;
            WAIT_LOW:
                if(z)
                    state = CHECK_NBITS;
                else
                    state = WAIT_LOW;
            CHECK_NBITS:
                if(c)
                    state = CS_HIGH;
                else
                    state = RESETEO_I;
            CS_HIGH:begin
                count1 <= count1 + 1;
                if(count1 > 23'd6_249_999) begin
                    count1 <= 0;
                    state <= END;
                end
                else begin
                    state <= CS_HIGH;
                end
            end
            END:begin
                count2 <= count2 + 1;
                if(count2 > 29) begin
                    count2 <= 0;
                    state <= START;
                end
                else begin
                    state <= END;
                end
            end
            default:
                state = START;

        endcase
    end
end

always @(* ) begin
    case (state)
        START: begin
            clk_spi  <= 0;
            cs_spi   <= 1;
            reset    <= 1;
            inc_i    <= 0;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
            inc_k    <= 0;
            
        end
        CS_LOW: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
            inc_k    <= 0;
        end
        WAIT_K: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
            inc_k    <= 1;
        end
        RESETEO_I: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 1;
            sh       <= 0;
            done_spi <= 0;
            inc_k    <= 0;
        end
        WAIT_HIGH: begin
            clk_spi  <= 1;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 1;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
            inc_k    <= 0;
        end
        SHIFT: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 1;
            sh       <= 1;
            done_spi <= 0;
            inc_k    <= 0;
        end
        WAIT_LOW: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 1;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
            inc_k    <= 0;
        end
        CHECK_NBITS: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
            inc_k    <= 0;
        end
        CS_HIGH: begin
            clk_spi  <= 0;
            cs_spi   <= 1;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
            inc_k    <= 0;
        end
        END: begin
            clk_spi  <= 0;
            cs_spi   <= 1;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 1;
            inc_k    <= 0;
        end
        default: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
            inc_k    <= 0;
        end

    endcase
end

`ifdef BENCH
reg [8*40:1] state_name;
always @(*) begin
  case(state)
    START     : state_name = "START";
    CS_LOW   : state_name = "CS_LOW";
    WAIT_K   : state_name = "WAIT_K";
    RESETEO_I   : state_name = "RESETEO_I";
    WAIT_HIGH  : state_name = "WAIT_HIGH";
    SHIFT   : state_name = "SHIFT";
    WAIT_LOW     : state_name = "WAIT_LOW";
    CHECK_NBITS : state_name = "CHECK_NBITS";
    CS_HIGH  : state_name = "CS_HIGH";
    END  : state_name = "END_SPI";
  endcase
end
`endif
endmodule