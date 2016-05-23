PROJECT=top
##TOP_LEVEL_FILE= ./RTL/top.v  ./RTL/0000_rs232c_tx_rx.v

# <Cyclone III, EP3C16F484C6 | Cyclone V,5CSEMA4U23C6 >
FAMILY="Cyclone V"
PART=5CSEMA4U23C6
NUMBER_PROCESSOR=`cat /proc/cpuinfo |grep "cpu cores" | wc -l`
############# map ##########
OPTIMIZE=balanced #<area | speed | balanced>

############# map ##########
PACKING_OPTION=minimize_area # <off|normal|minimize_area|minimize_area_with_chains|auto>

############# pgm ##########
PATH_CDF=./output_files/Chain1.cdf

############# sta ##########
PATH_SDC=./$(PROJECT).sdc
CABLE_NAME=DE-SoC[USB-1]

############# stp ##########
PATH_STP=./stp1.stp
PATH_STPTCL=./stp.tcl

############# sim ##########
PATH_SIM_LIB=/Applications/altera/13.1/quartus/eda/sim_lib/cycloneiii_atoms.v

all:
	quartus_sh --flow compile $(PROJECT)

init:
	-mkdir output_files
	cd ./SCRIPT; python InitMake.py $(PROJECT) $(FAMILY) $(PART)
	quartus_sh -t ./SCRIPT/init.tcl
	#quartus_map $(PROJECT) --source=$(TOP_LEVEL_FILE) --family="$(FAMILY)" --part=$(PART)
	
syntax: ./HDL/RTL/*.v
	cd SCRIPT; ./check_syntax.sh

map:
	quartus_map $(PROJECT) --optimize=$(OPTIMIZE) --parallel=$(NUMBER_PROCESSOR)
	#-mv $(PROJECT).flow.rpt MAP && mv $(PROJECT).map.* MAP

assign:
	quartus_sh -t SCRIPT/pin.tcl
	# cat ./SCRIPT/pin.tcl >> $(PROJECT).qsf

io_analysis:
	quartus_fit --check_ios $(PROJECT) --rev=$(PROJECT) --parallel=$(NUMBER_PROCESSOR)

fit:
	-rm FITTER/*
	# 初コンパイルはあまり努力させない
	quartus_fit $(PROJECT) --pack_register=off --parallel=$(NUMBER_PROCESSOR)
	-mv $(PROJECT).fit* ./FITTER/
	# timing analysis for the result of the previous fit
	quartus_sta $(PROJECT) --sdc $(PATH_SDC) --parallel=$(NUMBER_PROCESSOR)
	-mv $(PROJECT).sta.rpt ./TIMING/$(PROJECT)_0000_sta.rpt
	# -write_settings_files=off > qsfのアップデートを行わない
	quartus_fit $(PROJECT) --pack_register=$(PACKING_OPTION) --parallel=$(NUMBER_PROCESSOR)
	# timing analysis check
	quartus_sta $(PROJECT) --parallel=$(NUMBER_PROCESSOR)
	-mv $(PROJECT).sta.rpt ./TIMING/$(PROJECT)_0001_sta.rpt
	# sof pof 生成
	quartus_asm $(PROJECT) #[--rev=<revision name>]
	
sta:
	quartus_sta $(PROJECT) --do_report_timing --sdc $(PATH_SDC) --parallel=$(NUMBER_PROCESSOR)

build_program:
	# check USB Blaster name
	quartus_pgm -l
	quartus_pgm -c $(CABLE_NAME) -m JTAG $(PATH_CDF)
	
program:
	# when use NIOS Bash?
	#nios2-configure-sof ./output_files/$(PROJECT).sof
	# check USB Blaster name
	quartus_pgm -l
	# program .sof
	quartus_pgm -c DE-SoC[2-1.5] -m JTAG -o p\;output_files/$(PROJECT).sof

update_mif:
	quartus_cdb --update_mif $(PROJECT) #[--rev=<revision name>]
	quartus_asm $(PROJECT) #[--rev=<revision name>]

stp:
	-mkdir stp_log
	quartus_stp -t ./SCRIPT/stp.tcl

on_stp:
	quartus_stp $(PROJECT) --stp_file $(PATH_STP) --enable

off_stp:
	quartus_stp $(PROJECT) --stp_file $(PATH_STP) --disable

sim:
	# timing analysis
	quartus_sta $(PROJECT) --model=slow --sdc $(PATH_SDC) --parallel=$(NUMBER_PROCESSOR)
	quartus_sta $(PROJECT) --model=fas--sdc $(PATH_SDC) --parallel=$(NUMBER_PROCESSOR)
	# Use the quartus_eda executable to write out a gate-level
	# Verilog simulation netlist for ModelSim
	quartus_eda $(PROJECT) --simulation --tool=modelsim --format=verilog
# Perform the simulation with the ModelSim software
	vlib cycloneIII
	vlog -work cycloneIII $(PATH_SIM_LIB)
	vlib work
	vlog -work work $(PROJECT).vo
	vsim -L cycloneIII -t 1ps work.$(PROJECT)

## test
#  
# timing analysis
	#quartus_sta myproject --model=slow
	#quartus_sta myproject --model=fast

# Use the quartus_eda executable to write out a gate-level
# Verilog simulation netlist for ModelSim
	#quartus_eda my_project --simulation --tool=modelsim --format=verilog
