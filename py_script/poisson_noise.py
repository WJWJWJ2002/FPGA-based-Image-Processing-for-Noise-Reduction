import cv2
import sys
import os
import numpy as np

image_path = sys.argv[1]
style = sys.argv[2]
if style == "lena":
    original = os.path.join(image_path, "lena256.bmp")
    poisson_img = "lena_poisson.bmp"
elif style == "pepper":
    original = os.path.join(image_path, "pepper256.bmp")
    poisson_img = "pepper_poisson.bmp"
elif style == "baboon":
    original = os.path.join(image_path, "baboon256.bmp")
    poisson_img = "baboon_poisson.bmp"

original_img = cv2.imread(original, 0)
noisy = (np.random.poisson((original_img/255.0) * 20.0)/20.0) * 255.0
noisy = np.clip(noisy, 0, 255).astype(np.uint8)
cv2.imwrite(os.path.join(image_path, poisson_img), noisy)

