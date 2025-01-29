# Copyright (C) 2022 Xilinx, Inc
# SPDX-License-Identifier: BSD-3-Clause

## Switche
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports BTNC];
set_property -dict {PACKAGE_PIN L19 IOSTANDARD LVCMOS33} [get_ports CPU_RESETN];
# SPDX-License-Identifier: BSD-3-Clau

## LEDs
set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports {leds[0]}];
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {leds[1]}];
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {leds[2]}];
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {leds[3]}];

#PL CLOCK
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports CLK_IN];
create_clock -period 8.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports CLK_IN];
