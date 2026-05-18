import numpy as np
import os
import cv2
import sys

root_noise = sys.argv[1]
root_orig = sys.argv[2]

noisy_file = "Lena_Impulse_10.bmp"
orig_file = "lena256.bmp"
noisy_img = cv2.imread(os.path.join(root_noise, noisy_file), 0)
orig_img = cv2.imread(os.path.join(root_orig, orig_file), 0)

noise = noisy_img - orig_img
std_noise = np.std(noise)
std_spatial = std_noise*3
print(std_spatial)
