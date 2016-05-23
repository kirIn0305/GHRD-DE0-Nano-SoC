project_new top -overwrite
set VERILOG {./HDL/RTL/blinker.v ./HDL/RTL/delay_ctrl.v ./HDL/RTL/oneshot.v ./HDL/RTL/top.v}
set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CSEMA4U23C6
foreach i $VERILOG {
    set_global_assignment -name VERILOG_FILE $i
}
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
project_close