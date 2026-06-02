window_verif:
	cp -r ./simulation/modelsim/new_pix.txt .
	mv new_pix.txt ./logs_file/window_verif.txt
	python3 recover_img.py ${WORKAREA} 3x3_windows logs_file/window_verif.txt recover_lena.bmp 

median_verif:
	cp -r ./simulation/modelsim/new_pix.txt .
	cp -r ./simulation/modelsim/new_pix2.txt .
	cp -r ./simulation/modelsim/new_pix3.txt .
	mv new_pix.txt ./logs_file/median_verif.txt
	mv new_pix2.txt ./logs_file/median_verif2.txt
	mv new_pix3.txt ./logs_file/median_verif3.txt
	python3 recover_img.py ${WORKAREA} 3x3_windows logs_file/median_verif.txt recover_med.bmp
	python3 recover_img.py ${WORKAREA} 3x3_windows logs_file/median_verif2.txt pepper_med.bmp
	python3 recover_img.py ${WORKAREA} 3x3_windows logs_file/median_verif3.txt baboon_med.bmp

mean_verif:
	cp -r ./simulation/modelsim/new_pix.txt .
	cp -r ./simulation/modelsim/new_pix2.txt .
	cp -r ./simulation/modelsim/new_pix3.txt .
	mv new_pix.txt ./logs_file/mean_verif.txt
	mv new_pix2.txt ./logs_file/mean_verif2.txt
	mv new_pix3.txt ./logs_file/mean_verif3.txt
	python3 recover_img.py ${WORKAREA} 3x3_windows logs_file/mean_verif.txt recover_mean.bmp
	python3 recover_img.py ${WORKAREA} 3x3_windows logs_file/mean_verif2.txt pepper_mean.bmp
	python3 recover_img.py ${WORKAREA} 3x3_windows logs_file/mean_verif3.txt baboon_mean.bmp

bilateral_verif:
	cp -r ./simulation/modelsim/new_pix.txt .
	cp -r ./simulation/modelsim/new_pix2.txt .
	cp -r ./simulation/modelsim/new_pix3.txt .
	mv new_pix.txt ./logs_file/bilateral_verif.txt
	mv new_pix2.txt ./logs_file/bilateral_verif2.txt
	mv new_pix3.txt ./logs_file/bilateral_verif3.txt
	python3 recover_img.py ${WORKAREA} 3x3_windows logs_file/bilateral_verif.txt recover_bilateral.bmp
	python3 recover_img.py ${WORKAREA} 3x3_windows logs_file/bilateral_verif2.txt pepper_bilateral.bmp
	python3 recover_img.py ${WORKAREA} 3x3_windows logs_file/bilateral_verif3.txt baboon_bilateral.bmp

dummy_filter:
	python3 config_setup.py ${WORKAREA} 3x3_windows DUMMY_FILTER

median_filter:
	python3 config_setup.py ${WORKAREA} 3x3_windows MEDIAN_FILTER

mean_filter:
	python3 config_setup.py ${WORKAREA} 3x3_windows MEAN_FILTER

bilateral_filter:
	python3 config_setup.py ${WORKAREA} 3x3_windows BILATERAL_FILTER

# set environment variables for image style
# STYLE = lena, pepper, baboon
# txt = noisy_data_{STYLE}_{noise}.txt
# clean image from ./image, noisy image from py_script/images
noise_10:
	python3 ./py_script/'Salt and Pepper.py' ${WORKAREA}/3x3_windows/py_script 10 ${STYLE}

noise_15:
	python3 ./py_script/'Salt and Pepper.py' ${WORKAREA}/3x3_windows/py_script 15 ${STYLE}

noise_30:
	python3 ./py_script/'Salt and Pepper.py' ${WORKAREA}/3x3_windows/py_script 30 ${STYLE}

noise_20:
	python3 ./py_script/'Salt and Pepper.py' ${WORKAREA}/3x3_windows/py_script 20 ${STYLE}

noise_25:
	python3 ./py_script/'Salt and Pepper.py' ${WORKAREA}/3x3_windows/py_script 25 ${STYLE}

gauss_noise:
	python3 py_script/gaussian_noise.py ${WORKAREA}/3x3_windows/py_script/images ${STYLE}

poisson_noise:
	python3 py_script/poisson_noise.py ${WORKAREA}/3x3_windows/py_script/images ${STYLE}

# Set env variables for noisy image name and the type of noise it contains, the image style and the txt file
mif_gen: 
	python3 py_script/noisy_data_gen.py ${WORKAREA}/3x3_windows/py_script ${IUT}.bmp ${NOISE} ${STYLE}
	python3 py_script/mif_noise_gen.py 256 ${WORKAREA}/3x3_windows/py_script ${txt} ${NOISE} ${STYLE}

noise_div:
	python3 py_script/noise_div.py ${WORKAREA}/3x3_windows/py_script/images ${IUT}.bmp

eval:	
	python3 py_script/psnr_calc.py ${WORKAREA}/3x3_windows/ ${snp_density} ${STYLE}
