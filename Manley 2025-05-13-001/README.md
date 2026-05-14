this code generates the error shown below:


*** Running vivado
    with args -log clk_wiz_0.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source clk_wiz_0.tcl



****** Vivado v2025.1 (64-bit)
  **** SW Build 6140274 on Thu May 22 00:12:29 MDT 2025
  **** IP Build 6138677 on Thu May 22 03:10:11 MDT 2025
  **** SharedData Build 6139179 on Tue May 20 17:58:58 MDT 2025
  **** Start of session at: Wed May 13 22:53:09 2026
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
    ** Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.

source clk_wiz_0.tcl -notrace
create_project: Time (s): cpu = 00:00:14 ; elapsed = 00:00:10 . Memory (MB): peak = 492.781 ; gain = 210.387
Command: read_checkpoint -auto_incremental -incremental {C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/utils_1/imports/synth_1/clk_wiz_0.dcp}
INFO: [Vivado 12-5825] Read reference checkpoint from C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/utils_1/imports/synth_1/clk_wiz_0.dcp for incremental synthesis
INFO: [Vivado 12-7989] Please ensure there are no constraint changes
Command: synth_design -top clk_wiz_0 -part xc7a100tcsg324-1
Starting synth_design
Attempting to get a license for feature 'Synthesis' and/or device 'xc7a100t'
INFO: [Common 17-349] Got license for feature 'Synthesis' and/or device 'xc7a100t'
INFO: [Device 21-403] Loading part xc7a100tcsg324-1
INFO: [Designutils 20-5440] No compile time benefit to using incremental synthesis; A full resynthesis will be run
INFO: [Designutils 20-4379] Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}
INFO: [Synth 8-7079] Multithreading enabled for synth_design using a maximum of 2 processes.
INFO: [Synth 8-7078] Launching helper process for spawning children vivado processes
INFO: [Synth 8-7075] Helper process launched with PID 7476
---------------------------------------------------------------------------------
Starting RTL Elaboration : Time (s): cpu = 00:00:08 ; elapsed = 00:00:09 . Memory (MB): peak = 1205.762 ; gain = 494.508
---------------------------------------------------------------------------------
INFO: [Synth 8-6157] synthesizing module 'clk_wiz_0' [c:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.v:67]
INFO: [Synth 8-6157] synthesizing module 'clk_wiz_0_clk_wiz' [c:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_clk_wiz.v:67]
INFO: [Synth 8-6157] synthesizing module 'IBUF' [C:/Xilinx/2025.1/Vivado/scripts/rt/data/unisim_comp.v:76868]
INFO: [Synth 8-6155] done synthesizing module 'IBUF' (0#1) [C:/Xilinx/2025.1/Vivado/scripts/rt/data/unisim_comp.v:76868]
INFO: [Synth 8-6157] synthesizing module 'MMCME2_ADV' [C:/Xilinx/2025.1/Vivado/scripts/rt/data/unisim_comp.v:89421]
	Parameter BANDWIDTH bound to: OPTIMIZED - type: string 
	Parameter CLKFBOUT_MULT_F bound to: 10.000000 - type: double 
	Parameter CLKFBOUT_PHASE bound to: 0.000000 - type: double 
	Parameter CLKFBOUT_USE_FINE_PS bound to: FALSE - type: string 
	Parameter CLKIN1_PERIOD bound to: 10.000000 - type: double 
	Parameter CLKOUT0_DIVIDE_F bound to: 10.000000 - type: double 
	Parameter CLKOUT0_DUTY_CYCLE bound to: 0.500000 - type: double 
	Parameter CLKOUT0_PHASE bound to: 0.000000 - type: double 
	Parameter CLKOUT0_USE_FINE_PS bound to: FALSE - type: string 
	Parameter CLKOUT1_DIVIDE bound to: 20 - type: integer 
	Parameter CLKOUT1_DUTY_CYCLE bound to: 0.500000 - type: double 
	Parameter CLKOUT1_PHASE bound to: 0.000000 - type: double 
	Parameter CLKOUT1_USE_FINE_PS bound to: FALSE - type: string 
	Parameter CLKOUT2_DIVIDE bound to: 40 - type: integer 
	Parameter CLKOUT2_DUTY_CYCLE bound to: 0.500000 - type: double 
	Parameter CLKOUT2_PHASE bound to: 0.000000 - type: double 
	Parameter CLKOUT2_USE_FINE_PS bound to: FALSE - type: string 
	Parameter CLKOUT4_CASCADE bound to: FALSE - type: string 
	Parameter COMPENSATION bound to: ZHOLD - type: string 
	Parameter DIVCLK_DIVIDE bound to: 1 - type: integer 
	Parameter STARTUP_WAIT bound to: FALSE - type: string 
INFO: [Synth 8-6155] done synthesizing module 'MMCME2_ADV' (0#1) [C:/Xilinx/2025.1/Vivado/scripts/rt/data/unisim_comp.v:89421]
INFO: [Synth 8-6157] synthesizing module 'BUFG' [C:/Xilinx/2025.1/Vivado/scripts/rt/data/unisim_comp.v:2678]
INFO: [Synth 8-6155] done synthesizing module 'BUFG' (0#1) [C:/Xilinx/2025.1/Vivado/scripts/rt/data/unisim_comp.v:2678]
INFO: [Synth 8-6155] done synthesizing module 'clk_wiz_0_clk_wiz' (0#1) [c:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_clk_wiz.v:67]
INFO: [Synth 8-6155] done synthesizing module 'clk_wiz_0' (0#1) [c:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.v:67]
---------------------------------------------------------------------------------
Finished RTL Elaboration : Time (s): cpu = 00:00:10 ; elapsed = 00:00:11 . Memory (MB): peak = 1313.094 ; gain = 601.840
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Handling Custom Attributes
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Handling Custom Attributes : Time (s): cpu = 00:00:10 ; elapsed = 00:00:11 . Memory (MB): peak = 1313.094 ; gain = 601.840
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:10 ; elapsed = 00:00:11 . Memory (MB): peak = 1313.094 ; gain = 601.840
---------------------------------------------------------------------------------
Netlist sorting complete. Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 1313.094 ; gain = 0.000
INFO: [Netlist 29-17] Analyzing 1 Unisim elements for replacement
INFO: [Netlist 29-28] Unisim Transformation completed in 0 CPU seconds
INFO: [Project 1-570] Preparing netlist for logic optimization

Processing XDC Constraints
Initializing timing engine
Parsing XDC File [c:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc] for cell 'inst'
Finished Parsing XDC File [c:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc] for cell 'inst'
Parsing XDC File [c:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc] for cell 'inst'
Finished Parsing XDC File [c:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc] for cell 'inst'
INFO: [Project 1-236] Implementation specific constraints were found while reading constraint file [c:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [.Xil/clk_wiz_0_propImpl.xdc].
Resolution: To avoid this warning, move constraints listed in [.Xil/clk_wiz_0_propImpl.xdc] to another XDC file and exclude this new file from synthesis with the used_in_synthesis property (File Properties dialog in GUI) and re-run elaboration/synthesis.
INFO: [Timing 38-2] Deriving generated clocks
Parsing XDC File [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc]
WARNING: [Vivado 12-584] No ports matched 'CLK100MHZ'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:7]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:7]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'CLK100MHZ'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:8]
CRITICAL WARNING: [Vivado 12-4739] create_clock:No valid object(s) found for '-objects [get_ports CLK100MHZ]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:8]
Resolution: Check if the specified object(s) exists in the current design. If it does, ensure that the correct design hierarchy was specified for the object. If you are working with clocks, make sure create_clock was used to create the clock object before it is referenced.
WARNING: [Vivado 12-584] No ports matched 'SEG[0]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:60]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:60]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'SEG[1]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:61]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:61]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'SEG[2]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:62]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:62]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'SEG[3]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:63]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:63]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'SEG[4]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:64]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:64]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'SEG[5]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:65]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:65]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'SEG[6]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:66]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:66]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'DP'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:68]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:68]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'AN[0]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:70]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:70]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'AN[1]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:71]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:71]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'AN[2]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:72]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:72]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'AN[3]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:73]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:73]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'AN[4]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:74]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:74]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'AN[5]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:75]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:75]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'AN[6]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:76]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:76]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'AN[7]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:77]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:77]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_R[0]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:156]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:156]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_R[1]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:157]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:157]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_R[2]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:158]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:158]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_R[3]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:159]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:159]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_G[0]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:161]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:161]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_G[1]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:162]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:162]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_G[2]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:163]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:163]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_G[3]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:164]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:164]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_B[0]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:166]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:166]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_B[1]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:167]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:167]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_B[2]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:168]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:168]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_B[3]'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:169]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:169]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_HS'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:171]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:171]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'VGA_VS'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:172]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:172]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'UART_TXD'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:220]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:220]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'PS2_CLK'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:226]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:226]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
WARNING: [Vivado 12-584] No ports matched 'PS2_DATA'. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:227]
CRITICAL WARNING: [Common 17-55] 'set_property' expects at least one object. [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc:227]
Resolution: If [get_<value>] was used to populate the object, check to make sure this command returns at least one valid object.
Finished Parsing XDC File [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.srcs/constrs_1/new/Nexys-A7-100T-Master.xdc]
Parsing XDC File [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.runs/synth_1/dont_touch.xdc]
Finished Parsing XDC File [C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.runs/synth_1/dont_touch.xdc]
Completed Processing XDC Constraints

Netlist sorting complete. Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 1313.094 ; gain = 0.000
INFO: [Project 1-111] Unisim Transformation Summary:
No Unisim elements were transformed.

Constraint Validation Runtime : Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.004 . Memory (MB): peak = 1313.094 ; gain = 0.000
INFO: [Designutils 20-5440] No compile time benefit to using incremental synthesis; A full resynthesis will be run
INFO: [Designutils 20-4379] Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}
---------------------------------------------------------------------------------
Finished Constraint Validation : Time (s): cpu = 00:00:21 ; elapsed = 00:00:23 . Memory (MB): peak = 1313.094 ; gain = 601.840
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Loading Part and Timing Information
---------------------------------------------------------------------------------
Loading part: xc7a100tcsg324-1
---------------------------------------------------------------------------------
Finished Loading Part and Timing Information : Time (s): cpu = 00:00:21 ; elapsed = 00:00:23 . Memory (MB): peak = 1313.094 ; gain = 601.840
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Applying 'set_property' XDC Constraints
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:21 ; elapsed = 00:00:23 . Memory (MB): peak = 1313.094 ; gain = 601.840
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:21 ; elapsed = 00:00:23 . Memory (MB): peak = 1313.094 ; gain = 601.840
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start RTL Component Statistics 
---------------------------------------------------------------------------------
Detailed RTL Component Info : 
---------------------------------------------------------------------------------
Finished RTL Component Statistics 
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Part Resource Summary
---------------------------------------------------------------------------------
Part Resources:
DSPs: 240 (col length:80)
BRAMs: 270 (col length: RAMB18 80 RAMB36 40)
---------------------------------------------------------------------------------
Finished Part Resource Summary
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Cross Boundary and Area Optimization
---------------------------------------------------------------------------------
WARNING: [Synth 8-7080] Parallel synthesis criteria is not met
---------------------------------------------------------------------------------
Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:24 ; elapsed = 00:00:26 . Memory (MB): peak = 1323.766 ; gain = 612.512
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Applying XDC Timing Constraints
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:33 ; elapsed = 00:00:35 . Memory (MB): peak = 1493.742 ; gain = 782.488
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Timing Optimization
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Timing Optimization : Time (s): cpu = 00:00:33 ; elapsed = 00:00:35 . Memory (MB): peak = 1493.742 ; gain = 782.488
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Technology Mapping
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Technology Mapping : Time (s): cpu = 00:00:33 ; elapsed = 00:00:35 . Memory (MB): peak = 1503.332 ; gain = 792.078
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start IO Insertion
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Flattening Before IO Insertion
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Flattening Before IO Insertion
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Final Netlist Cleanup
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Final Netlist Cleanup
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished IO Insertion : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1738.094 ; gain = 1026.840
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Renaming Generated Instances
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Renaming Generated Instances : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1738.094 ; gain = 1026.840
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Rebuilding User Hierarchy
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1738.094 ; gain = 1026.840
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Renaming Generated Ports
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Renaming Generated Ports : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1738.094 ; gain = 1026.840
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Handling Custom Attributes
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Handling Custom Attributes : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1738.094 ; gain = 1026.840
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Renaming Generated Nets
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Renaming Generated Nets : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1738.094 ; gain = 1026.840
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Writing Synthesis Report
---------------------------------------------------------------------------------

Report BlackBoxes: 
+-+--------------+----------+
| |BlackBox name |Instances |
+-+--------------+----------+
+-+--------------+----------+

Report Cell Usage: 
+------+-----------+------+
|      |Cell       |Count |
+------+-----------+------+
|1     |BUFG       |     4|
|2     |MMCME2_ADV |     1|
|3     |IBUF       |     2|
|4     |OBUF       |     4|
+------+-----------+------+
---------------------------------------------------------------------------------
Finished Writing Synthesis Report : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1738.094 ; gain = 1026.840
---------------------------------------------------------------------------------
Synthesis finished with 0 errors, 0 critical warnings and 1 warnings.
Synthesis Optimization Runtime : Time (s): cpu = 00:00:28 ; elapsed = 00:00:40 . Memory (MB): peak = 1738.094 ; gain = 1026.840
Synthesis Optimization Complete : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1738.094 ; gain = 1026.840
INFO: [Project 1-571] Translating synthesized netlist
Netlist sorting complete. Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 1738.094 ; gain = 0.000
INFO: [Netlist 29-17] Analyzing 1 Unisim elements for replacement
INFO: [Netlist 29-28] Unisim Transformation completed in 0 CPU seconds
INFO: [Project 1-570] Preparing netlist for logic optimization
INFO: [Opt 31-138] Pushed 0 inverter(s) to 0 load pin(s).
Netlist sorting complete. Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.001 . Memory (MB): peak = 1750.926 ; gain = 0.000
INFO: [Project 1-111] Unisim Transformation Summary:
No Unisim elements were transformed.

Synth Design complete | Checksum: 51e69f33
INFO: [Common 17-83] Releasing license: Synthesis
34 Infos, 36 Warnings, 35 Critical Warnings and 0 Errors encountered.
synth_design completed successfully
synth_design: Time (s): cpu = 00:00:45 ; elapsed = 00:00:49 . Memory (MB): peak = 1750.926 ; gain = 1243.270
INFO: [runtcl-6] Synthesis results are not added to the cache due to CRITICAL_WARNING
Write ShapeDB Complete: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.008 . Memory (MB): peak = 1750.926 ; gain = 0.000
INFO: [Common 17-1381] The checkpoint 'C:/Users/niacnamaia/Documents/Programming Projects/CPE 487/sha256FullProject/sha256FullProject.runs/synth_1/clk_wiz_0.dcp' has been generated.
INFO: [Vivado 12-24828] Executing command : report_utilization -file clk_wiz_0_utilization_synth.rpt -pb clk_wiz_0_utilization_synth.pb
INFO: [Common 17-206] Exiting Vivado at Wed May 13 22:54:15 2026...
