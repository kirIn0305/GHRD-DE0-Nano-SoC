import os
import sys
import subprocess
import time
import draw_image
import draw_tcl
import imtools
import numpy as np
from PIL import Image
from matplotlib import pylab as plt

if __name__ == '__main__':
    loop_num = 0
    while True:
        text = "##################################################\n# loop number {0}\n##################################################".format(loop_num)
        print(text)
        filelist = imtools.get_imlist('../stp_log/csv/', 'csv')
        draw_tcl.draw_tcl()

        cmd = "cd ..; make stp"
        subprocess.call(cmd, shell=True)
        os.rename("../stp_log/tmp.csv", "../stp_log/csv/log_{0:08d}.csv".format(len(filelist)))
        
        if len(filelist) != 0:
            print("start drawing.........")
            print("     file name : {0}".format(filelist[-1]))
            dir_path, fname = os.path.split(filelist[-1])
            dir_path, dir_tmp = os.path.split(dir_path)
            name, ext = os.path.splitext(fname)
            wrfname = dir_path + "/image/" + name + ".jpg"
            if os.path.exists(wrfname):
                print(wrfname," already exists\n\twaiting............")
                continue
            draw_image.draw_image(filelist[-1], wrfname)
            #img = np.array( Image.open(wrfname) )
            #plt.imshow(img)

        # print("cature continue ?\n\tpress key (1: continue, 0:exit)")
        # flag_end = input()
        # if int(flag_end) == 0:
        #     exit(1)

            cmd = "xdg-open {0}".format(wrfname)
            subprocess.call(cmd, shell=True)
        print("if you want to stop, you should press <ctrl> + c in 3 seconds")
        time.sleep(3)
        loop_num+= 1
