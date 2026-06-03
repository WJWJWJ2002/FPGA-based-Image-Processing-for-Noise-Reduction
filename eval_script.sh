# !/bin/bash
# Automating evaluation python script
for i in {0..4}; do
	export snp_density=$((i*5 + 10))
	export STYLE=lena
	make eval
	export  STYLE=pepper
	make eval
	export STYLE=baboon
	make eval
done
	
