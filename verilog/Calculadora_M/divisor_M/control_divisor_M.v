
//28/05/26 Parece que ya esta
module control_divisor_M( clk , rst , init , ld_temp_lsbA ,  addi , c , done , msb , reset );

 input clk;
 input rst;
 input init;

// Estos son las señales entrada del Bloque de control:
 input c;
 input msb;

//Estos son las señales de salida del bloque de control:
 output reg reset;
 output reg sh;
 output reg addi;
 output reg ld_temp_lsbA;
 output reg done;


 parameter START  = 3'b000;
 parameter RCI = 3'b001;
 parameter CHECK_MSB  = 3'b010;
 parameter CHANGE_A_TEMP  = 3'b011;
 parameter CHECK_I   = 3'b100;
 parameter FINISH    = 3'b101;

 reg [2:0] state;


 initial begin
  sh = 0;
  ld_temp_lsbA = 0;
  lsb_A = 0;
  addi   = 0; 
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
        sh      <= 0;
        ld_temp_lsbA <= 0;
        lsb_A   <= 0;
        addi    <= 0; 
        done    <= 0;
        reset   <= 1;
        if(init)
          state <= RCI;
        else
          state <= START;
      end

     RCI: begin
      sh      <= 1;
      ld_temp_lsbA <= 0;
      lsb_A   <= 0;
      addi    <= 1; 
      done    <= 0;
      reset   <= 0;
      state = CHECK_MSB;
      end

     CHECK_MSB: begin
      sh      <= 0;
      ld_temp_lsbA <= 0;
      lsb_A   <= 0;
      addi    <= 0; 
      done    <= 0;
      reset   <= 0;
      if(msb)
        state <= CHECK_I;
      else
        state <= CHANGE_A_TEMP;
     end

     CHANGE_A_TEMP: begin
      sh      <= 0;
      ld_temp_lsbA <= 1;
      addi    <= 0; 
      done    <= 0;
      reset   <= 0;
      state = CHECK_I;
     end
     CHECK_I: begin
      sh      <= 0;
      ld_temp_lsbA <= 0;
      addi    <= 0; 
      done    <= 0;
      reset   <= 0;
      if (c == 16)
        state <= FINISH;
      else
        state <= RCI;
     end
    
     FINISH:begin
        done  <= 1;
        sh      <= 0;
        ld_temp_lsbA <= 0;
        lsb_A   <= 0;
        addi    <= 0; 
        done    <= 0;
        reset   <= 0;
        count = count + 1;
				state = (count>29) ? START : FINISH ;  // hace falta de 10 ciclos de reloj, para que lea el done y luego cargue el resultado
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
    CHECK_B    : state_name = "CHECK_B";
    CHECK_LSB    : state_name = "CHECK_LSB";
    SHIFT    : state_name = "SHIFT";
    ADD      : state_name = "ADD";
    FINISH      : state_name = "FINISH";
  endcase
end
`endif



endmodule