# -*- coding: utf-8 -*-

import datetime

def draw_tcl():
    d = datetime.datetime.today()
    time_stanp = "log_{0}-{1}-{2}_{3}:{4}.{5}".format(d.year, d.month, d.day, d.hour, d.minute, d.second)

    tcl_text = """#opens signaltap session
open_session -name ./stp1.stp

set LOG_NAME {0}

run -instance auto_signaltap_0 -signal_set "cap_camera_0" -trigger "start_trigger_0" -data_log $LOG_NAME 
close_session

open_session -name ./stp1.stp
export_data_log -clock_period 20 -instance "auto_signaltap_0" -signal_set "cap_camera_0" -trigger "start_trigger_0" -data_log $LOG_NAME -filename "./stp_log/tmp.csv" -format csv
close_session""".format(time_stanp)

    with open('../SCRIPT/stp.tcl', mode = 'w', encoding = 'utf-8') as fh:
        fh.write(tcl_text)

    print("\nsuccess draw_tcl\n\n")

if __name__ == '__main__':
    draw_tcl()
