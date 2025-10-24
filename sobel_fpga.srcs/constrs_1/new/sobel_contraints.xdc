## =========================================================
##  Basys 3 FPGA Board Constraints for Sobel Project
##  Device: xc7a35tcpg236-1  |  FPGA: Artix-7
##  Board Clock: 100 MHz onboard oscillator
##  Date Updated: 2025
## =========================================================

## --------------------------
##  Clock and Reset
## --------------------------

## 100 MHz system clock (onboard)
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 20.000 -name clk [get_ports clk]

## Center Pushbutton (BTN_C) used as reset
set_property PACKAGE_PIN U18 [get_ports rstn]
set_property IOSTANDARD LVCMOS33 [get_ports rstn]


## --------------------------
##  Input Pixels (8 bits)
##  Connect to switches SW0-SW7
## --------------------------
set_property PACKAGE_PIN V17 [get_ports {in_pixel[0]}]
set_property PACKAGE_PIN V16 [get_ports {in_pixel[1]}]
set_property PACKAGE_PIN W16 [get_ports {in_pixel[2]}]
set_property PACKAGE_PIN W17 [get_ports {in_pixel[3]}]
set_property PACKAGE_PIN W15 [get_ports {in_pixel[4]}]
set_property PACKAGE_PIN V15 [get_ports {in_pixel[5]}]
set_property PACKAGE_PIN W14 [get_ports {in_pixel[6]}]
set_property PACKAGE_PIN W13 [get_ports {in_pixel[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in_pixel[*]}]


## --------------------------
##  Output Pixels (8 bits)
##  Connect to LEDs LD0-LD7
## --------------------------
set_property PACKAGE_PIN U16 [get_ports {out_pixel[0]}]
set_property PACKAGE_PIN E19 [get_ports {out_pixel[1]}]
set_property PACKAGE_PIN U19 [get_ports {out_pixel[2]}]
set_property PACKAGE_PIN V19 [get_ports {out_pixel[3]}]
set_property PACKAGE_PIN W18 [get_ports {out_pixel[4]}]
set_property PACKAGE_PIN U15 [get_ports {out_pixel[5]}]
set_property PACKAGE_PIN U14 [get_ports {out_pixel[6]}]
set_property PACKAGE_PIN V14 [get_ports {out_pixel[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out_pixel[*]}]


## --------------------------
##  Optional Valid Signals
##  (If used in your design)
## --------------------------
# set_property PACKAGE_PIN T17 [get_ports in_valid]
# set_property PACKAGE_PIN T18 [get_ports out_valid]
# set_property IOSTANDARD LVCMOS33 [get_ports {in_valid out_valid}]

## --------------------------
##  Additional Control Signals
## --------------------------

## in_valid  -> BTN0 (left button)
set_property PACKAGE_PIN T17 [get_ports in_valid]
set_property IOSTANDARD LVCMOS33 [get_ports in_valid]

## in_ready  -> BTN1 (right button)
set_property PACKAGE_PIN U17 [get_ports in_ready]
set_property IOSTANDARD LVCMOS33 [get_ports in_ready]

## out_valid -> LED8 (upper right LED)
set_property PACKAGE_PIN T18 [get_ports out_valid]
set_property IOSTANDARD LVCMOS33 [get_ports out_valid]


## --------------------------
##  Timing Constraints
## --------------------------

# Input delays (simulation/demo purposes)
set_input_delay -clock clk -max 5.0 [get_ports {in_pixel[*] in_valid in_ready rstn}]
set_input_delay -clock clk -min 1.0 [get_ports {in_pixel[*] in_valid in_ready rstn}]

# Output delays (simulation/demo purposes)
set_output_delay -clock clk -max 5.0 [get_ports {out_pixel[*] out_valid}]
set_output_delay -clock clk -min 1.0 [get_ports {out_pixel[*] out_valid}]