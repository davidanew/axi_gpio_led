# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: C:\Users\david\fpga\axi_gpio_led\axi_gpio_led_sw_system\_ide\scripts\systemdebugger_axi_gpio_led_sw_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source C:\Users\david\fpga\axi_gpio_led\axi_gpio_led_sw_system\_ide\scripts\systemdebugger_axi_gpio_led_sw_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Arty Z7 003017A4C854A" && level==0 && jtag_device_ctx=="jsn-Arty Z7-003017A4C854A-13722093-0"}
fpga -file C:/Users/david/fpga/axi_gpio_led/axi_gpio_led_sw/_ide/bitstream/design_1_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw C:/Users/david/fpga/axi_gpio_led/axi_gpio_led_platform/export/axi_gpio_led_platform/hw/design_1_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source C:/Users/david/fpga/axi_gpio_led/axi_gpio_led_sw/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow C:/Users/david/fpga/axi_gpio_led/axi_gpio_led_sw/Debug/axi_gpio_led_sw.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
