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

## DATE    "Fri May 15 04:46:01 2026"

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


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {clk}]  0.010  
set_clock_uncertainty -rise_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {clk}]  0.010  
set_clock_uncertainty -fall_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {clk}]  0.010  
set_clock_uncertainty -fall_from [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {clk}]  0.010  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay -max -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  1.811 [get_ports {rst_sync}]
set_input_delay -add_delay -min -clock [get_clocks {PLL_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.873 [get_ports {rst_sync}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.500 [get_ports {done_filt_ff}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {done_filt_ff}]
set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.500 [get_ports {new_pix_ff[0]}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {new_pix_ff[0]}]
set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.500 [get_ports {new_pix_ff[1]}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {new_pix_ff[1]}]
set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.500 [get_ports {new_pix_ff[2]}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {new_pix_ff[2]}]
set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.500 [get_ports {new_pix_ff[3]}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {new_pix_ff[3]}]
set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.500 [get_ports {new_pix_ff[4]}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {new_pix_ff[4]}]
set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.500 [get_ports {new_pix_ff[5]}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {new_pix_ff[5]}]
set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.500 [get_ports {new_pix_ff[6]}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {new_pix_ff[6]}]
set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.500 [get_ports {new_pix_ff[7]}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {new_pix_ff[7]}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path -to [get_ports {rst_valid}]


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

