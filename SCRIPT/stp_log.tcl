open_session -name ./stp1.stp
export_data_log -clock_period 20 -instance auto_signaltap_0 -signal_set cap_camera_0 -trigger start_trigger_0 -data_log log_6 -filename "./stp_log/tmp.csv" -format csv
close_session
