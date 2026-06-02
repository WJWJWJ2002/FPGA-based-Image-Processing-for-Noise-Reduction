import cv2
import sys
import os
import numpy as np

image_path = sys.argv[1]
style = sys.argv[2]
if style == "lena":
    original = os.path.join(image_path, "lena256.bmp")
    gauss_img = "lena_gauss.bmp"
elif style == "pepper":
    original = os.path.join(image_path, "pepper256.bmp")
    gauss_img = "pepper_gauss.bmp"
elif style == "baboon":
    original = os.path.join(image_path, "baboon256.bmp")
    gauss_img = "baboon_gauss.bmp"

noise = np.zeros((256, 256))
original_img = cv2.imread(original, 0)
mean = 0
std = 40
noise = np.random.normal(mean, std, (256,256)).astype(np.float32)
noisy_img = noise.astype(np.float32) + original_img
noisy_img = np.clip(noisy_img, 0, 255).astype(np.uint8)
cv2.imwrite(os.path.join(image_path, gauss_img), noisy_img)

