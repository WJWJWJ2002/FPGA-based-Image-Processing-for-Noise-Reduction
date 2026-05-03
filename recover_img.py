import cv2
import os
import numpy as np
import sys
root = sys.argv[1] 
folder = sys.argv[2]
input_data = sys.argv[3]
img_file = sys.argv[4]
img_path = os.path.join(root, folder)
data_path = os.path.join(root, folder)
data_path = os.path.join(data_path, input_data)

img_data = np.zeros((256,256), dtype=np.uint8)
start = False
with open(data_path, "r") as data_file:
    line = data_file.readlines()
    x = 0
    y = 0
    for l in line:
        if (l.strip("# \n") == "end"):
            start = False
            continue

        if (l.strip("# \n") == "start"):
            start = True
            continue

        if start == True:
            img_data[y][x] = np.uint8(int(l.strip("# \n"), 16))
            x = x + 1
            if x == 256:
                y = y + 1
                x = 0
            
cv2.imwrite(os.path.join(img_path, img_file), img_data);

