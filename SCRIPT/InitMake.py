# -*- coding: utf-8 -*-
import sys
import os

if __name__ == '__main__':
    argvs = sys.argv  # コマンドライン引数を格納したリストの取得
    argc = len(argvs) - 2 # verilogの個数
    v_files = argvs[2:]
    path = "../HDL/RTL"
    extention = "v"
    filelist = [os.path.join(path,f) for f in os.listdir(path) if f.endswith(extention)]

    text = "project_new {0} -overwrite\nset VERILOG {{".format(argvs[1])

    for v_file in filelist:
        tmp = v_file
        v_file = tmp.replace(os.path.sep, '/')
        text += "{0} ".format(v_file[1:])
    text = text[:-1] 
    text += "}\n"

    text += 'set_global_assignment -name FAMILY "{0}"\n'.format(argvs[2])
    text += 'set_global_assignment -name DEVICE {0}\n'.format(argvs[3])

    text += """foreach i $VERILOG {
    set_global_assignment -name VERILOG_FILE $i
}
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
project_close"""
    f = open('./init.tcl', 'w') # 書き込みモードで開く
    f.write(text) # 引数の文字列をファイルに書き込む
    f.close() # ファイルを閉じる
