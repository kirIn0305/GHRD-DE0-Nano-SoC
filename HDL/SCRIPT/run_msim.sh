#!/bin/sh

if [ $# -ne 2 ]; then
    echo "select arguments is $#" 1>&2
    echo "Usage : $CMDNAME SIMULATION_DIRECTORY GUI_SELECT" 1>&2
    exit 1
fi

# RTL directory
RTL_DIR="../../RTL"
test_module="tbench"

# TBENCH .v
# sim_file=$1
QUARTUS_INSTALL_DIR="/Applications/altera/15.0"
# SIM directory
sim_dir=$1
sim_file="./tb/tbench.v"
echo "Test Pattern = " $sim_dir


# make work dir
if [ ! -e ./work ]; then
    vlib ./work 
fi

# make altera Mega whizard library
#if [ ! -e ./altera_mf_ver ]; then
    vlib ./altera_mf_ver
    vlog     "${QUARTUS_INSTALL_DIR}/quartus/eda/sim_lib/altera_mf.v" -work altera_mf_ver        
#fi


# compile
vlog \
    +notimingchecks \
    -sv \
    -y ${RTL_DIR} \
    +incdir+${RTL_DIR}/+ \
    +libext+.v+ \
    -f "${RTL_DIR}/ALTERA_IP/pll.v" \
    ${sim_file}

# simulation
if [ "$2" = "-nogui" ]; then 
## if you use on CUI
vsim -c -keepstdout ${test_module} -L ${QUARTUS_INSTALL_DIR}/modelsim_ase/altera/verilog/altera_mf 
# run -all
#vsim -c -keepstdout test_module <<EOF
#EOF
elif [ "$2" = "-gui" ]; then
## if you use on GUI
#vsim -gui test_module <<EOF
#vsim -gui -L ${QUARTUS_INSTALL_DIR}/modelsim_ase/altera/verilog/altera_mf  ${test_module} 
vsim -gui -L altera_mf_ver ${test_module} 
# run -all
#EOF
else
	echo "boo, select window on or off"
fi
