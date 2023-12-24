# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\david\fpga\axi_gpio_led\axi_gpio_led_platform\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\david\fpga\axi_gpio_led\axi_gpio_led_platform\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {axi_gpio_led_platform}\
-hw {C:\Users\david\fpga\axi_gpio_led\axi_gpio_led_vivado\design_1_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -out {C:/Users/david/fpga/axi_gpio_led}

platform write
platform generate -domains 
platform active {axi_gpio_led_platform}
platform generate
platform active {axi_gpio_led_platform}
platform active {axi_gpio_led_platform}
platform active {axi_gpio_led_platform}
platform config -updatehw {C:/Users/david/fpga/axi_gpio_led/axi_gpio_led_vivado/design_1_wrapper.xsa}
platform generate
