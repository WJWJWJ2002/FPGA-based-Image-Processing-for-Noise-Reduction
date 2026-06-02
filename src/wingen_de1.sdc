## Generated SDC file "wingen_de1.sdc"

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

## DATE    "Tue Jun 02 15:47:13 2026"

##
## DEVICE  "5CSEMA5F31C6"
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

create_generated_clock -name {PLL_inst|pll_cyc_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} -source [get_pins {PLL_inst|pll_cyc_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin}] -duty_cycle 50/1 -multiply_by 12 -divide_by 2 -master_clock {clk} [get_pins {PLL_inst|pll_cyc_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}] 
create_generated_clock -name {outclk_150} -source [get_pins {PLL_inst|pll_cyc_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 2 -master_clock {PLL_inst|pll_cyc_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} [get_pins {PLL_inst|pll_cyc_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] 
create_generated_clock -name {outclk_25} -source [get_pins {PLL_inst|pll_cyc_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 12 -master_clock {PLL_inst|pll_cyc_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} [get_pins {PLL_inst|pll_cyc_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {outclk_25}] -rise_to [get_clocks {outclk_25}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {outclk_25}] -rise_to [get_clocks {outclk_25}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {outclk_25}] -fall_to [get_clocks {outclk_25}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {outclk_25}] -fall_to [get_clocks {outclk_25}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {outclk_25}] -rise_to [get_clocks {outclk_25}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {outclk_25}] -rise_to [get_clocks {outclk_25}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {outclk_25}] -fall_to [get_clocks {outclk_25}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {outclk_25}] -fall_to [get_clocks {outclk_25}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {outclk_150}] -rise_to [get_clocks {outclk_150}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {outclk_150}] -rise_to [get_clocks {outclk_150}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {outclk_150}] -fall_to [get_clocks {outclk_150}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {outclk_150}] -fall_to [get_clocks {outclk_150}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {outclk_150}] -rise_to [get_clocks {outclk_150}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {outclk_150}] -rise_to [get_clocks {outclk_150}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {outclk_150}] -fall_to [get_clocks {outclk_150}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {outclk_150}] -fall_to [get_clocks {outclk_150}] -hold 0.060  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay -max -clock [get_clocks {outclk_150}]  2.000 [get_ports {img_sel[0]}]
set_input_delay -add_delay -min -clock [get_clocks {outclk_150}]  1.500 [get_ports {img_sel[0]}]
set_input_delay -add_delay -max -clock [get_clocks {outclk_150}]  2.000 [get_ports {img_sel[1]}]
set_input_delay -add_delay -min -clock [get_clocks {outclk_150}]  1.500 [get_ports {img_sel[1]}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_BLANK_N}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_BLANK_N}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_B[0]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_B[0]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_B[1]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_B[1]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_B[2]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_B[2]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_B[3]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_B[3]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_B[4]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_B[4]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_B[5]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_B[5]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_B[6]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_B[6]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_B[7]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_B[7]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_CLK}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_CLK}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_G[0]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_G[0]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_G[1]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_G[1]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_G[2]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_G[2]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_G[3]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_G[3]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_G[4]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_G[4]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_G[5]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_G[5]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_G[6]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_G[6]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_G[7]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_G[7]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_HS}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_HS}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_R[0]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_R[0]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_R[1]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_R[1]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_R[2]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_R[2]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_R[3]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_R[3]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_R[4]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_R[4]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_R[5]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_R[5]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_R[6]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_R[6]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_R[7]}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_R[7]}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_SYNC_N}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_SYNC_N}]
set_output_delay -add_delay -max -clock [get_clocks {outclk_25}]  3.491 [get_ports {VGA_VS}]
set_output_delay -add_delay -min -clock [get_clocks {outclk_25}]  3.293 [get_ports {VGA_VS}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path  -from  [get_clocks {outclk_25}]  -to  [get_clocks {outclk_150}]
set_false_path  -from  [get_clocks {outclk_150}]  -to  [get_clocks {outclk_25}]
set_false_path -to [get_ports {new_pix_ff*}]
set_false_path -to [get_ports {outclk_150}]
set_false_path -to [get_ports {seg*}]
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

