
TARGET=binToBCD
TOP=binToBCD

OBJS = acc_binToBCD_M.v binToBCD_M.v control_binToBCD_M.v main_process_binToBCD_M.v
PER_OBJS = perip_binToBCD_M.v $(OBJS)

BUILD_DIR = build

all: sim

sim:
	rm -f a.out *.vcd
	iverilog -DBENCH -DSIM -DPASSTHROUGH_PLL -DBOARD_FREQ=27 -DCPU_FREQ=27  $(TARGET)_TB_M.v $(OBJS)
	vvp a.out
	gtkwave $(TARGET)_TB_M.vcd

sim_per:
	rm -f a.out *.vcd
	iverilog -DBENCH -DSIM -DPASSTHROUGH_PLL -DBOARD_FREQ=27 -DCPU_FREQ=27  perip_$(TARGET)_TB_M.v $(PER_OBJS)
	vvp a.out
	gtkwave perip_$(TARGET)_TB_M.vcd


svg: $(OBJS)
	yosys -p "prep -top ${TARGET}_M; write_json ${TARGET}_M.json" ${OBJS}
	netlistsvg ${TARGET}_M.json -o ${TARGET}_M.svg  #--skin default.svg
	yosys -p "prep -top ${TARGET}_M -flatten; write_json ${TARGET}_M_flat.json" ${OBJS}
	netlistsvg ${TARGET}_M_flat.json -o ${TARGET}_M_flat.svg  #--skin default.svg

clean:
	rm -rf *.out *.vcd *.svg *.json
