import cv2
import numpy as np
import sys
import os
from math import log10, pow
from skimage.metrics import structural_similarity as SSIM

# Functions for calculating MSE and PSNR
def psnr_calc(img_orig, img_new):
    mse = (np.square(img_new.astype(np.float32) - img_orig.astype(np.float32))).mean()
    psnr = 10*log10(pow(255, 2)/mse)
    return round(psnr, 3), round(mse, 3)

# Function for calculating SSIM 
def ssim_calc(img_orig, img_new):
    pixel_range = float(img_new.max() - img_new.min())
    ssim = SSIM(im1=img_orig, im2=img_new, win_size=3, data_range=pixel_range)
    return round(ssim, 3)

# Arguments for style of image being evaluated, salt and pepper noise density and relevant file directories
root = sys.argv[1]
snp_density = sys.argv[2]
style = sys.argv[3]
root_noise = os.path.join(root, "noisy_img")
root_original = os.path.join(root, "image")
root_recovered = os.path.join(root, "recovered_img")
# Evaluation logs
log_name = "eval_" + style + ".txt"
# Open noise free image for calculation
if style == "lena":
    noise_free = cv2.imread(os.path.join(root_original, "lena256.bmp"), 0)
elif style == "pepper":
    noise_free = cv2.imread(os.path.join(root_original, "pepper256.bmp"), 0)
elif style == "baboon":
    noise_free = cv2.imread(os.path.join(root_original, "baboon256.bmp"), 0)

if int(snp_density) == 10:
    if style == "lena":
        salt_and_pepper = cv2.imread(os.path.join(root_original, "recover_lena.bmp"), 0)
    elif style == "pepper":
        salt_and_pepper = cv2.imread(os.path.join(root_noise, "Pepper_Impulse_10.bmp"), 0)
    elif style == "baboon":
        salt_and_pepper = cv2.imread(os.path.join(root_noise, "Baboon_Impulse_10.bmp"), 0)
else:
    if style == "lena":
        snp_file = "Lena_Impulse_" + snp_density + ".bmp" 
        salt_and_pepper = cv2.imread(os.path.join(root_noise, snp_file), 0)
    elif style == "pepper":
        snp_file = "Pepper_Impulse_" + snp_density + ".bmp" 
        salt_and_pepper = cv2.imread(os.path.join(root_noise, snp_file), 0)
    elif style == "baboon":
        snp_file = "Baboon_Impulse_" + snp_density + ".bmp" 
        salt_and_pepper = cv2.imread(os.path.join(root_noise, snp_file), 0)

# Opens noisy images for original PSNR, MSE and SSIM
if style == "lena":
    gaussian = cv2.imread(os.path.join(root_noise, "lena_gauss.bmp"), 0)
    poisson = cv2.imread(os.path.join(root_noise, "lena_poisson.bmp"), 0)
elif style == "pepper":
    gaussian = cv2.imread(os.path.join(root_noise, "pepper_gauss.bmp"), 0)
    poisson = cv2.imread(os.path.join(root_noise, "pepper_poisson.bmp"), 0)
elif style == "baboon":
    gaussian = cv2.imread(os.path.join(root_noise, "baboon_gauss.bmp"), 0)
    poisson = cv2.imread(os.path.join(root_noise, "baboon_poisson.bmp"), 0)

# Saves PSNR, SSIM and MSE of noisy images
psnr_snp, mse_snp = psnr_calc(noise_free, salt_and_pepper)
psnr_gauss, mse_gauss = psnr_calc(noise_free, gaussian)
psnr_poisson, mse_poisson = psnr_calc(noise_free, poisson)
ssim_snp = ssim_calc(noise_free, salt_and_pepper)
ssim_gauss = ssim_calc(noise_free, gaussian)
ssim_poisson = ssim_calc(noise_free, poisson)
#print(f"Salt and Pepper: PSNR = {psnr_snp}       SSIM = {ssim_snp}")
#print(f"Gaussian Noise: PSNR = {psnr_gauss}     SSIM = {ssim_gauss}")
#print(f"Poisson Noise: PSNR = {psnr_poisson}     SSIM = {ssim_poisson}")
with open(log_name, "a") as f:
    f.write("--------------- Noisy image information ---------------\n")
    f.write(f"Salt and Pepper: PSNR = {psnr_snp}       SSIM = {ssim_snp}\n")
    f.write(f"Gaussian Noise: PSNR = {psnr_gauss}     SSIM = {ssim_gauss}\n")
    f.write(f"Poisson Noise: PSNR = {psnr_poisson}     SSIM = {ssim_poisson}\n\n")
# Initiating list for PSNR,MSE,SSIM
psnr_mean = list()
psnr_median = list()
psnr_bilateral = list()
mse_mean = list()
mse_median = list()
mse_bilateral = list()
ssim_median = list()
ssim_mean = list()
ssim_bilateral = list()

# Loop through all noisy images 
for i in range(3):
    if i == 0:
        if int(snp_density) == 10:
            if style == "lena":
                snp_density = ""
        if style == "lena":
            recovered_mean = cv2.imread(os.path.join(root_recovered, f"recover_mean_snp{snp_density}.bmp"), 0)
            recovered_med = cv2.imread(os.path.join(root_recovered, f"recover_med_snp{snp_density}.bmp"), 0)
            recovered_bilateral = cv2.imread(os.path.join(root_recovered, f"recover_bilateral_snp{snp_density}.bmp"), 0)
        elif style == "pepper":
            recovered_mean = cv2.imread(os.path.join(root_recovered, f"pepper_mean_snp{snp_density}.bmp"), 0)
            recovered_med = cv2.imread(os.path.join(root_recovered, f"pepper_med_snp{snp_density}.bmp"), 0)
            recovered_bilateral = cv2.imread(os.path.join(root_recovered, f"pepper_bilateral_snp{snp_density}.bmp"), 0)
        elif style == "baboon":
            recovered_mean = cv2.imread(os.path.join(root_recovered, f"baboon_mean_snp{snp_density}.bmp"), 0)
            recovered_med = cv2.imread(os.path.join(root_recovered, f"baboon_med_snp{snp_density}.bmp"), 0)
            recovered_bilateral = cv2.imread(os.path.join(root_recovered, f"baboon_bilateral_snp{snp_density}.bmp"), 0)
        psnr_mean.append(psnr_calc(noise_free, recovered_mean)[0])
        psnr_median.append(psnr_calc(noise_free, recovered_med)[0])
        psnr_bilateral.append(psnr_calc(noise_free, recovered_bilateral)[0])
        mse_mean.append(psnr_calc(noise_free, recovered_mean)[1])
        mse_median.append(psnr_calc(noise_free, recovered_med)[1])
        mse_bilateral.append(psnr_calc(noise_free, recovered_bilateral)[1])
        ssim_mean.append(ssim_calc(noise_free, recovered_mean))
        ssim_median.append(ssim_calc(noise_free, recovered_med))
        ssim_bilateral.append(ssim_calc(noise_free, recovered_bilateral))
    elif i == 1:
        if style ==  "lena":
            recovered_mean = cv2.imread(os.path.join(root_recovered, "recover_mean_gauss.bmp"), 0)
            recovered_med = cv2.imread(os.path.join(root_recovered, "recover_med_gauss.bmp"), 0)
            recovered_bilateral = cv2.imread(os.path.join(root_recovered, "recover_bilateral_gauss.bmp"), 0)
        elif style == "pepper":
            recovered_mean = cv2.imread(os.path.join(root_recovered, "pepper_mean_gauss.bmp"), 0)
            recovered_med = cv2.imread(os.path.join(root_recovered, "pepper_med_gauss.bmp"), 0)
            recovered_bilateral = cv2.imread(os.path.join(root_recovered, "pepper_bilateral_gauss.bmp"), 0)
        elif style == "baboon":
            recovered_mean = cv2.imread(os.path.join(root_recovered, "baboon_mean_gauss.bmp"), 0)
            recovered_med = cv2.imread(os.path.join(root_recovered, "baboon_med_gauss.bmp"), 0)
            recovered_bilateral = cv2.imread(os.path.join(root_recovered, "baboon_bilateral_gauss.bmp"), 0)
        psnr_mean.append(psnr_calc(noise_free, recovered_mean)[0])
        psnr_median.append(psnr_calc(noise_free, recovered_med)[0])
        psnr_bilateral.append(psnr_calc(noise_free, recovered_bilateral)[0])
        mse_mean.append(psnr_calc(noise_free, recovered_mean)[1])
        mse_median.append(psnr_calc(noise_free, recovered_med)[1])
        mse_bilateral.append(psnr_calc(noise_free, recovered_bilateral)[1])
        ssim_mean.append(ssim_calc(noise_free, recovered_mean))
        ssim_median.append(ssim_calc(noise_free, recovered_med))
        ssim_bilateral.append(ssim_calc(noise_free, recovered_bilateral))
    else:
        if style == "lena":
            recovered_mean = cv2.imread(os.path.join(root_recovered, "recover_mean_poisson.bmp"), 0)
            recovered_med = cv2.imread(os.path.join(root_recovered, "recover_med_poisson.bmp"), 0)
            recovered_bilateral = cv2.imread(os.path.join(root_recovered, "recover_bilateral_poisson.bmp"), 0)
        elif style == "pepper":
            recovered_mean = cv2.imread(os.path.join(root_recovered, "pepper_mean_poisson.bmp"), 0)
            recovered_med = cv2.imread(os.path.join(root_recovered, "pepper_med_poisson.bmp"), 0)
            recovered_bilateral = cv2.imread(os.path.join(root_recovered, "pepper_bilateral_poisson.bmp"), 0)
        elif style == "baboon":
            recovered_mean = cv2.imread(os.path.join(root_recovered, "baboon_mean_poisson.bmp"), 0)
            recovered_med = cv2.imread(os.path.join(root_recovered, "baboon_med_poisson.bmp"), 0)
            recovered_bilateral = cv2.imread(os.path.join(root_recovered, "baboon_bilateral_poisson.bmp"), 0)
        psnr_mean.append(psnr_calc(noise_free, recovered_mean)[0])
        psnr_median.append(psnr_calc(noise_free, recovered_med)[0])
        psnr_bilateral.append(psnr_calc(noise_free, recovered_bilateral)[0])
        mse_mean.append(psnr_calc(noise_free, recovered_mean)[1])
        mse_median.append(psnr_calc(noise_free, recovered_med)[1])
        mse_bilateral.append(psnr_calc(noise_free, recovered_bilateral)[1])
        ssim_mean.append(ssim_calc(noise_free, recovered_mean))
        ssim_median.append(ssim_calc(noise_free, recovered_med))
        ssim_bilateral.append(ssim_calc(noise_free, recovered_bilateral))

#print("PSNR of denoised images")
#print(f"Mean Filter: {psnr_mean}")
#print(f"Median Filter: {psnr_median}")
#print(f"Bilateral Filter: {psnr_bilateral}")
#print("SSIM of denoised images")
#print(f"Mean Filter: {ssim_mean}")
#print(f"Median Filter: {ssim_median}")
#print(f"Bilateral Filter: {ssim_bilateral}")
with open(log_name, "a") as f:
    f.write("------- PSNR of denoised images -------\n")
    f.write(f"Mean Filter: {psnr_mean}\n")
    f.write(f"Median Filter: {psnr_median}\n")
    f.write(f"Bilateral Filter: {psnr_bilateral}\n\n")
    f.write("------- MSE of denoised images ------- \n")
    f.write(f"Mean Filter: {mse_mean}\n")
    f.write(f"Median Filter: {mse_median}\n")
    f.write(f"Bilateral Filter: {mse_bilateral}\n\n")
    f.write("------- SSIM of denoised images ------- \n")
    f.write(f"Mean Filter: {ssim_mean}\n")
    f.write(f"Median Filter: {ssim_median}\n")
    f.write(f"Bilateral Filter: {ssim_bilateral}\n\n\n")

