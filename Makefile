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


