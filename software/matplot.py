import imtools
import matplotlib.pyplot as plt
import matplotlib.image as mpimg

filelist = imtools.get_imlist('../stp_log/image/', 'jpg')
for fname in filelist:
    img=mpimg.imread(fname) #image to array
    plt.imshow(img) #array to 2Dfigure

    plt.show()
