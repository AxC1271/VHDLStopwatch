set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.0 -name sys_clk -waveform {0 5} [get_ports clk]

set_property PACKAGE_PIN U18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

set_property PACKAGE_PIN W7 [get_ports {segment[6]}]  
set_property PACKAGE_PIN W6 [get_ports {segment[5]}]  
set_property PACKAGE_PIN U8 [get_ports {segment[4]}]  
set_property PACKAGE_PIN V8 [get_ports {segment[3]}]  
set_property PACKAGE_PIN U5 [get_ports {segment[2]}]  
set_property PACKAGE_PIN V5 [get_ports {segment[1]}]  
set_property PACKAGE_PIN U7 [get_ports {segment[0]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {segment[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment[0]}]

set_property PACKAGE_PIN W4 [get_ports {anode[0]}]  
set_property PACKAGE_PIN U2 [get_ports {anode[1]}] 
set_property PACKAGE_PIN U4 [get_ports {anode[2]}]  
set_property PACKAGE_PIN V4 [get_ports {anode[3]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {anode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[3]}]
