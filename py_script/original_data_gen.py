import cv2
import os
import sys

root = sys.argv[1]
noise_density = sys.argv[2]
input_img = sys.argv[3]
data_file_name = "original_noisy_data_" + noise_density + ".txt"
img_file = os.path.join(root, input_img)
img = cv2.imread(img_file, 0)
image_size = img.shape[0]
print(image_size);
data_file = open(os.path.join(root, data_file_name), "w")
for i in range(image_size):
    for j in range(image_size):
        data_file.writelines(f"{img[i][j]}\n")
data_file.close()

