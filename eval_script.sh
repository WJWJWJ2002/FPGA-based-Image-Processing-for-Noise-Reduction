#!/bin/bash
# Automating evaluation python script
rm -f eval_lena.txt eval_pepper.txt eval_baboon.txt
for i in {0..4}; do
	export snp_density=$((i*5 + 10))
	export STYLE=lena
	make eval
	export  STYLE=pepper
	make eval
	export STYLE=baboon
	make eval
done
	
