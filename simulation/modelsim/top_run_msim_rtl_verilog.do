transcript on
if ![file isdirectory top_iputf_libs] {
	file mkdir top_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "/home/vacent/MY_GHRD_FPGA/HDL/RTL/ALTERA_IP/pll_sim/pll.vo"

vlog -vlog01compat -work work +incdir+/home/vacent/MY_GHRD_FPGA/HDL/RTL {/home/vacent/MY_GHRD_FPGA/HDL/RTL/CamCap.v}
vlog -vlog01compat -work work +incdir+/home/vacent/MY_GHRD_FPGA/HDL/RTL {/home/vacent/MY_GHRD_FPGA/HDL/RTL/top.v}

vlog -vlog01compat -work work +incdir+/home/vacent/MY_GHRD_FPGA/HDL/TBENCH/SIM2/tb {/home/vacent/MY_GHRD_FPGA/HDL/TBENCH/SIM2/tb/tbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tbench

add wave *
view structure
view signals
run -all
