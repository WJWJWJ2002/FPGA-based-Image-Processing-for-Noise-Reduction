import cv2
import matplotlib.pyplot as plt
import random
import sys
import os
noise_density = int(sys.argv[2])
root = sys.argv[1]

def add_salt_and_pepper_noise(image, prob=float(noise_density)/100):
    noisy_image = image.copy()
    num_salt = int(prob * image.size * 0.5)
    num_pepper = int(prob * image.size * 0.5)
    
    for i in range(num_salt):
        while 1:
            x = random.randint(0, 255)
            y = random.randint(0, 255)
            if noisy_image[y][x] != 255 and noisy_image[y][x] != 0:
                break
        noisy_image[y][x] = 255
    for i in range(num_pepper):
        while 1:
            y = random.randint(0, 255)
            x = random.randint(0, 255)
            if noisy_image[y][x] != 255 and noisy_image[y][x] != 0:
                break
        noisy_image[y][x] = 0    
    return noisy_image

img_name = "Lena_Impulse_" + sys.argv[2] + ".bmp"
output_img = os.path.join(root, img_name)
clean_img = r'/mnt/c/Users/HP/Desktop/3x3_windows'
img = cv2.imread(os.path.join(clean_img, "lena256.bmp"), 0)
print(img.shape)
noisy_img = add_salt_and_pepper_noise(img)
cv2.imwrite(output_img, noisy_img)
plt.figure(figsize=(12, 6))
plt.subplot(121), plt.imshow(img, cmap='gray'), plt.title("Original Image")
plt.subplot(122), plt.imshow(noisy_img, cmap='gray'), plt.title("Salt and Pepper Noise Added")
plt.show()
