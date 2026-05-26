TARGET=multiplicador_32
TOP=multiplicador_32

OBJS = shiftR_16_M.v shiftL_32_M.v comp_M.v acc_M.v control_mult_M.v multiplicador_32_M.v
PER_OBJS = perip_mult_M.v $(OBJS)

BUILD_DIR = build

all: sim

sim:
	rm -f a.out *.vcd
	iverilog -DBENCH -DSIM -DPASSTHROUGH_PLL -DBOARD_FREQ=27 -DCPU_FREQ=27  $(TARGET)_TB_M.v $(OBJS)
	vvp a.out
	gtkwave $(TARGET)_TB_M.vcd $(TARGET)_M.gtkw

sim_per:
	rm -f a.out *.vcd
	iverilog -DBENCH -DSIM -DPASSTHROUGH_PLL -DBOARD_FREQ=27 -DCPU_FREQ=27  perip_$(TARGET)_TB_M.v $(PER_OBJS)
	vvp a.out
	gtkwave perip_$(TARGET)_TB_M.vcd $(TARGET)_M.gtkw


svg: $(OBJS)
	yosys -p "prep -top ${TARGET}_M; write_json ${TARGET}_M.json" ${OBJS}
	netlistsvg ${TARGET}_M.json -o ${TARGET}_M.svg  #--skin default.svg
	yosys -p "prep -top ${TARGET}_M -flatten; write_json ${TARGET}_flat_M.json" ${OBJS}
	netlistsvg ${TARGET}_flat_M.json -o ${TARGET}_flat_M.svg  #--skin default.svg

clean:
	rm -rf *.out *.vcd *.svg *.json
