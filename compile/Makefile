

comp: clean
	vcs \
	-sverilog \
	+incdir+${UVM_HOME} \
	${UVM_HOME}/uvm_pkg.sv \
	-f ${AHB_VIP_HOME}/ahb_interface/ahb_interface_filelist.f \
	-f ${AHB_VIP_HOME}/ahb_master/ahb_master_transaction/ahb_master_transaction_filelist.f \
	-f ${AHB_VIP_HOME}/ahb_master/ahb_master_agent_filelist.f \
	-f ${PWD}/filelist.f


clean:
	rm -rf csrc run.log simv.daidir vc_hdrs.h simv

