## Generated SDC file "wingen.sdc"

## Copyright (C) 2018  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

## DATE    "Tue May 19 01:47:33 2026"

##
## DEVICE  "10M50DAF484C7G"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {PLL_inst|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {PLL_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 2 -master_clock {clk} [get_pins {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {PLL_inst|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {PLL_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 2 -master_clock {clk} [get_pins {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {rst_sync}]
set_input_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {rst_sync}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  2.011 [get_ports {VGA_B[0]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.500 [get_ports {VGA_B[0]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  2.011 [get_ports {VGA_B[1]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.500 [get_ports {VGA_B[1]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  2.011 [get_ports {VGA_B[2]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.500 [get_ports {VGA_B[2]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  2.011 [get_ports {VGA_B[3]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.500 [get_ports {VGA_B[3]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  2.011 [get_ports {VGA_G[0]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.500 [get_ports {VGA_G[0]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  2.011 [get_ports {VGA_G[1]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.500 [get_ports {VGA_G[1]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  2.011 [get_ports {VGA_G[2]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.500 [get_ports {VGA_G[2]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  2.011 [get_ports {VGA_G[3]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.500 [get_ports {VGA_G[3]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.811 [get_ports {VGA_HS}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.800 [get_ports {VGA_HS}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  2.011 [get_ports {VGA_R[0]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.500 [get_ports {VGA_R[0]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  2.011 [get_ports {VGA_R[1]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.500 [get_ports {VGA_R[1]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  2.011 [get_ports {VGA_R[2]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.500 [get_ports {VGA_R[2]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  2.011 [get_ports {VGA_R[3]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.500 [get_ports {VGA_R[3]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  1.811 [get_ports {VGA_VS}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.800 [get_ports {VGA_VS}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {done_filt_ff}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {done_filt_ff}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {new_pix_ff[0]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {new_pix_ff[0]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {new_pix_ff[1]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {new_pix_ff[1]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {new_pix_ff[2]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {new_pix_ff[2]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {new_pix_ff[3]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {new_pix_ff[3]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {new_pix_ff[4]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {new_pix_ff[4]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {new_pix_ff[5]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {new_pix_ff[5]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {new_pix_ff[6]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {new_pix_ff[6]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {new_pix_ff[7]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {new_pix_ff[7]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {rst_valid}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {rst_valid}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg1[0]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg1[0]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg1[1]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg1[1]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg1[2]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg1[2]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg1[3]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg1[3]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg1[4]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg1[4]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg1[5]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg1[5]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg1[6]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg1[6]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg1[7]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg1[7]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg2[0]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg2[0]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg2[1]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg2[1]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg2[2]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg2[2]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg2[3]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg2[3]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg2[4]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg2[4]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg2[5]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg2[5]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg2[6]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg2[6]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg2[7]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg2[7]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg3[0]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg3[0]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg3[1]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg3[1]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg3[2]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg3[2]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg3[3]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg3[3]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg3[4]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg3[4]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg3[5]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg3[5]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg3[6]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg3[6]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg3[7]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg3[7]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg4[0]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg4[0]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg4[1]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg4[1]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg4[2]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg4[2]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg4[3]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg4[3]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg4[4]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg4[4]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg4[5]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg4[5]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg4[6]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg4[6]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg4[7]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg4[7]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg5[0]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg5[0]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg5[1]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg5[1]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg5[2]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg5[2]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg5[3]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg5[3]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg5[4]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg5[4]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg5[5]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg5[5]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg5[6]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg5[6]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg5[7]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg5[7]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg6[0]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg6[0]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg6[1]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg6[1]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg6[2]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg6[2]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg6[3]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg6[3]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg6[4]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg6[4]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg6[5]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg6[5]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg6[6]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg6[6]}]
set_output_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {seg6[7]}]
set_output_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.900 [get_ports {seg6[7]}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path  -from  [get_clocks {clk}]  -to  [get_clocks {*|pll*|clk[1]}]
set_false_path  -from  [get_clocks {clk}]  -to  [get_clocks {*|pll*|clk[0]}]
set_false_path  -from  [get_clocks {*|pll*|clk[0]}]  -to  [get_clocks {*|pll*|clk[1]}]
set_false_path  -from  [get_clocks {*|pll*|clk[1]}]  -to  [get_clocks {*|pll*|clk[0]}]
set_false_path  -from  [get_clocks {*|pll*|clk[1]}]  -to  [get_clocks {clk}]
set_false_path  -from  [get_clocks {*|pll*|clk[0]}]  -to  [get_clocks {clk}]
set_false_path -to [get_ports {rst_valid}]
set_false_path -to [get_ports {new_pix_ff*}]
set_false_path -to [get_ports {seg*}]
set_false_path -to [get_ports {seg1* seg2* seg3* seg4* seg5* seg6*}]
set_false_path -to [get_ports {done_filt_ff}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

