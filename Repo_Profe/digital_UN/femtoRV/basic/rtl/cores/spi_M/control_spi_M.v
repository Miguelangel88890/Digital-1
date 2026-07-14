module control_spi_M (
    input clk,
    input rst,
    input init_spi,  
    // Estos son las señales entrada del Bloque de control:
    input c,
    input z,
    //Estos son las señales de salida del bloque de control:
    output reg rst_i,
    output reg inc_i,
    output reg reset,
    output reg sh,
    //registros que se deben modificar
    output reg clk_spi,
    output reg cs_spi,
    output reg done_spi
);


 parameter START     = 3'b000;
 parameter CS_LOW   = 3'b001;
 parameter WAIT_HIGH  = 3'b010;
 parameter SHIFT   = 3'b011;
 parameter WAIT_LOW     = 3'b100;
 parameter CHECK_NBITS = 3'b101;
 parameter CS_HIGH  = 3'b110;
 parameter END  = 3'b111;

reg [2:0] state;
always @(posedge clk ) begin
    if (rst) begin
        state = START;
    end else begin
        case (state)
            START:
                if(init_spi)
                    state = CS_LOW;
                else
                    state = START;
            CS_LOW:
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
                    state = CS_LOW;
            CS_LOW:
                state <= END; 
            END:
                state <= START;
            default:
                state = START;

        endcase
    end
end

always @(* ) begin
    case (state)
        START: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 1;
            inc_i    <= 0;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
            
        end
        CS_LOW: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 1;
            sh       <= 0;
            done_spi <= 0;
        end
        WAIT_HIGH: begin
            clk_spi  <= 1;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 1;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
        end
        SHIFT: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 1;
            sh       <= 1;
            done_spi <= 0;
        end
        WAIT_LOW: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 1;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
        end
        CHECK_NBITS: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
        end
        CS_HIGH: begin
            clk_spi  <= 0;
            cs_spi   <= 1;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
        end
        END: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 1;
        end
        default: begin
            clk_spi  <= 0;
            cs_spi   <= 0;
            reset    <= 0;
            inc_i    <= 0;
            rst_i    <= 0;
            sh       <= 0;
            done_spi <= 0;
        end

    endcase
end

`ifdef BENCH
reg [8*40:1] state_name;
always @(*) begin
  case(state)
    START     : state_name = "START";
    CS_LOW   : state_name = "CS_LOW";
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