module control_mult_M( clk , rst , lsb_B , init , z , done , sh , reset , add );

 input clk;
 input rst;
 input init;

 input lsb_B;
 input z;

 output reg done;
 output reg sh;
 output reg reset;
 output reg add;


 parameter START  = 3'b000;
 parameter CHECK_B  = 3'b001;
 parameter CHECK_LSB  = 3'b010;
 parameter SHIFT  = 3'b011;
 parameter ADD    = 3'b100;
 parameter FINISH    = 3'b101;

 reg [2:0] state;

 initial begin
  done  = 0;
  sh    = 0;
  reset = 0;
  add   = 0; 
  state = 0;
 end

always @(posedge clk) begin
    if (rst) begin
      state = START;
    end else begin
    case(state)

      START:begin
        done  <= 0;
        sh    <= 0;
        reset <= 1;
        add   <= 0;
        if(init)
          state = CHECK_B;
        else
          state = START;
      end

     CHECK_B: begin
      done  <= 0;
      sh    <= 0;
      reset <= 0;
      add   <= 0;
      if(z)
        state = FINISH;
      else
        state = CHECK_LSB;
      end

     CHECK_LSB: begin
      done  <= 0;
      sh    <= 0;
      reset <= 0;
      add   <= 0;
      if(lsb_B)
        state = ADD;
      else
        state = SHIFT;
     end

     SHIFT: begin
      done  <= 0;
      sh    <= 1;
      reset <= 0;
      add   <= 0;
      state = CHECK_B;
     end
     ADD: begin
        done  <= 0;
        sh    <= 0;
        reset <= 0;
        add   <= 1;
        state = SHIFT;
     end
     FINISH: begin
        done  <= 1;
        sh    <= 0;
        reset <= 0;
        add   <= 0;
        state = START;
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