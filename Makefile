window_verif:
	cp -r ./simulation/questa/msim_transcript .
	mv msim_transcript ./logs_file/window_verif.txt
	python3 recover_img.py ${WORKAREA} 3x3_windows logs_file/window_verif.txt recover_lena.bmp

median_verif:
	cp -r ./simulation/questa/msim_transcript .
	mv msim_transcript ./logs_file/median_verif.txt
	python3 recover_img.py ${WORKAREA} 3x3_windows logs_file/median_verif.txt recover_med.bmp

mean_verif:
	cp -r ./simulation/questa/msim_transcript .
	mv msim_transcript ./logs_file/mean_verif.txt
	python3 recover_img.py ${WORKAREA} 3x3_windows logs_file/mean_verif.txt recover_mean.bmp

dummy_filter:
	python3 config_setup.py ${WORKAREA} 3x3_windows DUMMY_FILTER

median_filter:
	python3 config_setup.py ${WORKAREA} 3x3_windows MEDIAN_FILTER

mean_filter:
	python3 config_setup.py ${WORKAREA} 3x3_windows MEAN_FILTER

noise_10:
	python3 ./py_script/'Salt and Pepper.py' ${WORKAREA}/3x3_windows/py_script 10

noise_5:
	python3 ./py_script/'Salt and Pepper.py' ${WORKAREA}/3x3_windows/py_script 5

noise_15:
	python3 ./py_script/'Salt and Pepper.py' ${WORKAREA}/3x3_windows/py_script 15

noise_20:
	python3 ./py_script/'Salt and Pepper.py' ${WORKAREA}/3x3_windows/py_script 20

dat_5:
	python3 ./py_script/original_data_gen.py ${WORKAREA}/3x3_windows/py_script 5 Lena_Impulse_5.bmp

dat_10:
	python3 ./py_script/original_data_gen.py ${WORKAREA}/3x3_windows/py_script 10 Lena_Impulse_10.bmp  

dat_15:
	python3 ./py_script/original_data_gen.py ${WORKAREA}/3x3_windows/py_script 15 Lena_Impulse_15.bmp

dat_20:
	python3 ./py_script/original_data_gen.py ${WORKAREA}/3x3_windows/py_script 20 Lena_Impulse_20.bmp
	
mif_5:
	python3 ./py_script/mif_noise_gen.py 256 ${WORKAREA}/3x3_windows/py_script original_noisy_data_5.txt 5

mif_10:
	python3 ./py_script/mif_noise_gen.py 256 ${WORKAREA}/3x3_windows/py_script original_noisy_data_10.txt 10

mif_15:
	python3 ./py_script/mif_noise_gen.py 256 ${WORKAREA}/3x3_windows/py_script original_noisy_data_15.txt 15
	
mif_20:
	python3 ./py_script/mif_noise_gen.py 256 ${WORKAREA}/3x3_windows/py_script original_noisy_data_20.txt 20

