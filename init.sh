
# source the VCS tool
source /home/student/cadWorkDir/synopsys/.cshrc

# Path of the uvm package
setenv UVM_HOME "${PWD}/uvm-1.1d/src"

# path for the vip files
setenv AHB_VIP_HOME "${PWD}/ahb_vip"

setenv VK_HOME "${PWD}"

setenv VK_VERIF_DIR "${VK_HOME}/verif"

setenv DUT_DIR "${VK_HOME}/dut"
