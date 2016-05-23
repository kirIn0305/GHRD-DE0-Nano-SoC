#opens signaltap session
open_session -name ./stp1.stp

set LOG_NAME log_2015-11-16_15:23.49

run -instance auto_signaltap_0 -signal_set "cap_camera_0" -trigger "start_trigger_0" -data_log $LOG_NAME 
close_session

open_session -name ./stp1.stp
export_data_log -clock_period 20 -instance "auto_signaltap_0" -signal_set "cap_camera_0" -trigger "start_trigger_0" -data_log $LOG_NAME -filename "./stp_log/tmp.csv" -format csv
close_session