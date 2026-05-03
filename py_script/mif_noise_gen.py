import os
import sys

img_size = int(sys.argv[1])
root = sys.argv[2]
txt_file = sys.argv[3]
width = 8
input_folder = os.path.join(root, txt_file)
output_folder = "noisy_img_" + sys.argv[4] + ".mif"
img_data_file = open(input_folder, "r")
mif_file = open(os.path.join(root, output_folder), "w")
mif_file.write(f"DEPTH={img_size*img_size};\n")
mif_file.write(f"WIDTH={width};\n")
mif_file.write("ADDRESS_RADIX=UNS;\n")
mif_file.write("DATA_RADIX=HEX;\n")
mif_file.write("CONTENT\nBEGIN\n")
for i in range(img_size):
    for j in range(img_size):
        addr = i*img_size + j
        pix = int(img_data_file.readline())
        pix = hex(pix)

        # print(f"{addr} : {pix}\n")
        mif_file.write(f"\t\t{addr}\t\t:\t\t")
        mif_file.write(f"{pix[2:]};\n")

mif_file.write("END;\n");
mif_file.close()
img_data_file.close()
