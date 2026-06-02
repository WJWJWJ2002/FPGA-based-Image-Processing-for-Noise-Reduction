import cv2
import os
import sys

root = sys.argv[1]
input_img = sys.argv[2]
noise = sys.argv[3]
style = sys.argv[4]
root_img = os.path.join(root, "images")
txt_folder = os.path.join(root, "image_data_text")
if style == "lena":
    data_file_name = "noisy_data_" + noise + ".txt"
elif style == "pepper":
    data_file_name = "noisy_data_pepper_" + noise + ".txt"
elif style == "baboon":
    data_file_name = "noisy_data_baboon_" + noise + ".txt"

img_file = os.path.join(root_img, input_img)
img = cv2.imread(img_file, 0)
image_size = img.shape[0]
print(image_size);
data_file = open(os.path.join(txt_folder, data_file_name), "w")
for i in range(image_size):
    for j in range(image_size):
        data_file.writelines(f"{img[i][j]}\n")
data_file.close()

