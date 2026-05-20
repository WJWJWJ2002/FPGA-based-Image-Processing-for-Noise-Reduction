set_global_assignment -entity "PLL_cyc" -library "lib_PLL_cyc" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "PLL_cyc" -library "lib_PLL_cyc" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "PLL_cyc" -library "lib_PLL_cyc" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_PLL_cyc" -name SPD_FILE [file join $::quartus(sip_path) "PLL_cyc.spd"]

set_global_assignment -library "lib_PLL_cyc" -name MISC_FILE [file join $::quartus(sip_path) "PLL_cyc_sim/PLL_cyc.vo"]
