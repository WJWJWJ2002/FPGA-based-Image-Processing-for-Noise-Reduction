import sys
import os

root = sys.argv[1]
folder = sys.argv[2]
FUT = sys.argv[3]

param_file = os.path.join(root, folder)
param_file = os.path.join(param_file, "parameters.vh")

with open(param_file, "w") as param_init:
    param_init.write(f"`define {FUT}\n")
    param_init.write("parameter[3:0] DATA_WIDTH = 4'd8, FIFO_BITS = 4'd8;\n")
    param_init.write("parameter[4:0] MEM_BITS = 5'd16;\n")
    param_init.write("parameter[8:0] FIFO_DEPTH = 9'd256;\n")

