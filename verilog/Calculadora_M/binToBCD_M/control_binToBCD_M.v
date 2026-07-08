
//28/05/26 Parece que ya esta
module control_binToBCD_M( clk , rst , init , c , msb1 , msb2 , msb3 , reset , sh , ld1 , ld2 , ld3  , done );

 input clk;
 input rst;
 input init;

// Estos son las señales entrada del Bloque de control:
 input c;
 input msb1;
 input msb2;
 input msb3;

//Estos son las señales de salida del bloque de control:
 output reg reset;
 output reg sh;
 output reg ld1;
 output reg ld2;
 output reg ld3;
 output reg done;


 parameter START  = 3'b000;
 parameter CHECK_MSB = 3'b001;
 parameter UPDATE_GROUPS  = 3'b010;
 parameter REG_CORR  = 3'b011;
 parameter CHECK_I   = 3'b100;
 parameter FINISH    = 3'b101;

 reg [2:0] state;


 initial begin
  sh = 0;
  ld1 = 0;
  ld2 = 0;
  ld3 = 0;
  done  = 0;
  reset = 0;
  state = 0;
 end

 // Este es el que hace esperar en finish para que en el programa alcance a leer el DONE.
 reg [4:0] count; /////////////////////////

always @(posedge clk) begin
    if (rst) begin
      state = START;
    end else begin
    case(state)

      START:begin
        reset   <= 1;
        sh      <= 0;
        ld1     <= 0;
        ld2     <= 0;
        ld3     <= 0;
        done    <= 0;
        count   <= 0;
        if(init)
          state <= CHECK_MSB;
        else
          state <= START;
      end

      CHECK_MSB:begin
        reset   <= 0;
        sh      <= 0;
        ld1     <= 0;
        ld2     <= 0;
        ld3     <= 0;
        done    <= 0;
        if (~msb1 || ~msb2 || ~msb3) begin
          state <= UPDATE_GROUPS;
        end
        else begin
          state <= REG_CORR;
        end
      end

      UPDATE_GROUPS:begin
        reset   <= 0;
        sh      <= 0;
        if(~msb1) begin
          ld1 <= 1;
        end
        if(~msb2) begin
          ld2 <= 1;
        end
        if(~msb3) begin
          ld3 <= 1;
        end
        done    <= 0;
        state <= REG_CORR;
      end
    
    REG_CORR:begin
        reset   <= 0;
        sh      <= 1;
        ld1     <= 0;
        ld2     <= 0;
        ld3     <= 0;
        done    <= 0;
        state <= CHECK_I;
      end

    CHECK_I:begin
        reset   <= 0;
        sh      <= 0;
        ld1     <= 0;
        ld2     <= 0;
        ld3     <= 0;
        done    <= 0;
        if (c) begin
          state <= FINISH;
        end
        else begin
          state <= CHECK_MSB;
        end
      end

     FINISH:begin
        done  <= 1;
        count = count + 1;
				state = (count>29) ? START : FINISH ;  // hace falta de 10 ciclos de reloj, para que lea el done y luego cargue el resultado
        sh      <= 0;
        ld1 <= 0;
        ld2 <= 0;
        ld3 <= 0;
        reset   <= 0;
     end

     default: state = START;
   endcase
  end
end

`ifdef BENCH
reg [8*40:1] state_name;
always @(*) begin
  case(state)
    START    : state_name = "START";
    CHECK_MSB    : state_name = "CHECK_MSB";
    UPDATE_GROUPS    : state_name = "UPDATE_GROUPS";
    REG_CORR    : state_name = "REG_CORR";
    CHECK_I      : state_name = "CHECK_I";
    FINISH      : state_name = "FINISH";
  endcase
end
`endif



endmodule