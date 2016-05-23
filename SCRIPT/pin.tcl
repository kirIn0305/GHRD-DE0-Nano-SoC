project_open top

#============================================================
# FPGA
#============================================================
set_location_assignment PIN_V11 -to CLOCK_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK_50
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FPGA_CLK2_50
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FPGA_CLK3_50

#============================================================
# SW
#============================================================
set_location_assignment PIN_L10 -to KEY[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[0]
set_location_assignment PIN_L9 -to KEY[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[1]
set_location_assignment PIN_H6 -to KEY[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[2]
set_location_assignment PIN_H5 -to KEY[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[3]

#============================================================
# LED
#============================================================
set_location_assignment PIN_W15 -to LED[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[0]
set_location_assignment PIN_AA24 -to LED[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[1]
set_location_assignment PIN_V16 -to LED[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[2]
set_location_assignment PIN_V15 -to LED[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[3]


set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"

project_close
