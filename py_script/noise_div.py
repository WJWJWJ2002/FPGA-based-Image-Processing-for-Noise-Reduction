import numpy as np
import os
import cv2
import sys

root_img = sys.argv[1]
noisy_file = sys.argv[2]
orig_file = "lena256.bmp"
noisy_img = cv2.imread(os.path.join(root_img, noisy_file), 0)
orig_img = cv2.imread(os.path.join(root_img, orig_file), 0)

noise = noisy_img.astype(np.float32) - orig_img.astype(np.float32)
std_noise = np.std(noise)
std_spatial = std_noise*3
print(std_spatial)
