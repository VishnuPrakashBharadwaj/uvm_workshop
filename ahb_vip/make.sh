#!/bin/sh
export AHB_VIP_HOME=/home/logie/projects/BMS_ahb_template
rm -rf work/
vlib work
vlog +incdir+${UVM_HOME}/src/ ${UVM_HOME}/src/uvm_pkg.sv
vlog +incdir+${UVM_HOME}/src/ +incdir+${AHB_VIP_HOME}/ahb_interface/ ${AHB_VIP_HOME}/ahb_interface//ahb_interface.sv
vlog +incdir+${UVM_HOME}/src/ +incdir+${AHB_VIP_HOME}/ahb_interface/ ${AHB_VIP_HOME}/ahb_interface//ahb_enum_pkg.sv
vlog +incdir+${UVM_HOME}/src/ +incdir+${AHB_VIP_HOME}/ahb_master/ahb_master_transaction/ ${AHB_VIP_HOME}/ahb_master/ahb_master_transaction//ahb_master_transaction_pkg.sv
vlog +incdir+${UVM_HOME}/src/ +incdir+${AHB_VIP_HOME}/ahb_master/ ${AHB_VIP_HOME}/ahb_master//ahb_master_agent_pkg.sv
