
module control_raizCuadrada_M( clk , rst , init , c , msb  , reset , sh , set , ld , done );

 input clk;
 input rst;
 input init;

// Estos son las señales entrada del Bloque de control:
 input c;
 input msb;

//Estos son las señales de salida del bloque de control:
 output reg reset;
 output reg sh;
 output reg set;
 output reg ld;
 output reg done;


 parameter START  = 3'b000;
 parameter REG_CORR = 3'b001;
 parameter SETEO  = 3'b010;
 parameter CHECK_MSB  = 3'b011;
 parameter WRITE_RTA   = 3'b100;
 parameter CHECK_I   = 3'b101;
 parameter FINISH   = 3'b110;

 reg [2:0] state;


 initial begin
  reset = 0;
  sh = 0;
  set   = 0; 
  ld = 0;
  done  = 0;
  
  state = 0;
 end

 // Este es el que hace esperar en finish para que en el programa alcance a leer el DONE.
 reg [4:0] count; /////////////////////////

always @(posedge clk) begin
    if (rst) begin
      state = START;
      count = 0;
    end else begin
    case(state)

      START:begin
            reset = 1;
            sh = 0;
            set   = 0; 
            ld = 0;
            done  = 0;
        if(init)
          state <= REG_CORR;
        else
          state <= START;
      end

     REG_CORR: begin
      reset = 0;
      sh = 1;
      set   = 0; 
      ld = 0;
      done  = 0;
      state =  SETEO;
      end

     SETEO: begin
      reset = 0;
      sh = 0;
      set   = 1; 
      ld = 0;
      done  = 0;
      state = CHECK_MSB;
     end

     CHECK_MSB: begin
      reset = 0;
      sh = 0;
      set   = 0; 
      ld = 0;
      done  = 0;
      if(msb)
        state <= CHECK_I;
      else
        state <= WRITE_RTA;
     end

     WRITE_RTA: begin
      reset = 0;
      sh = 0;
      set   = 0; 
      ld = 1;
      done  = 0;
      state = CHECK_I;
     end

     CHECK_I: begin
      reset = 0;
      sh = 0;
      set   = 0; 
      ld = 0;
      done  = 0;
      if (c)
        state <= FINISH;
      else
        state <= REG_CORR;
     end
    
     FINISH:begin
        reset = 0;
        sh = 0;
        set   = 0; 
        ld = 0;
        done  = 1;
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
    REG_CORR    : state_name = "REG_CORR";
    CHECK_MSB    : state_name = "CHECK_MSB";
    SETEO    : state_name = "SETEO";
    CHECK_I      : state_name = "CHECK_I";
    WRITE_RTA    : state_name = "WRITE_RTA";
    FINISH      : state_name = "FINISH";
  endcase
end
`endif



endmodule