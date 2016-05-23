TBENCH = ./tb/tbench.v
VERILOG = ../RTL/div_u.v

all:
	iverilog -o ./test.vpp $(TBENCH) $(VERILOG)
	./test.vpp
	gtkwave ./test.vcd
