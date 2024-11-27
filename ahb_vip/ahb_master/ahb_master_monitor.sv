////----------------------------------------------------------------------
//// This file has been automatically generated by
//// VerifStudio Software Version 0.63, Accelver Systems Inc.
//// Any modifications that you make to this file may be
//// overwritten by the tool when regenerating the files. 
////----------------------------------------------------------------------

`ifndef AHB_MASTER_MONITOR__SV
`define AHB_MASTER_MONITOR__SV

class ahb_master_monitor#(AHB_ADDR_WIDTH=16,AHB_DATA_WIDTH=16) extends uvm_monitor;

    // Declare a handle to the configdb object associated with this agent.
    ahb_master_config#(AHB_ADDR_WIDTH,AHB_DATA_WIDTH) config_db;

    // Declare a handle to the Virtual Interface
    virtual ahb_interface#(AHB_ADDR_WIDTH,AHB_DATA_WIDTH) vif;

    // Register the class ahb_master_monitor with the factory.
    `uvm_component_param_utils(ahb_master_monitor#(AHB_ADDR_WIDTH,AHB_DATA_WIDTH))

    // The Constructor for this Class.
    function new(string name="ahb_master_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // Declare the build phase of the UVM Monitor.
    extern virtual function void build_phase(uvm_phase phase);

    // Declare the connect phase of the UVM Monitor.
    extern virtual function void connect_phase(uvm_phase phase);

    // Declare the run phase of the UVM Monitor.
    extern task run_phase(uvm_phase phase);

endclass: ahb_master_monitor


// Define the build phase of the UVM Monitor.
function void ahb_master_monitor::build_phase(uvm_phase phase);

    super.build_phase(phase);

    `uvm_info(get_type_name(), "Inside the Build Phase of ahb_master_monitor.", UVM_HIGH)

    // Get the config_object from the uvm_config_db.
    if(!uvm_config_db#(ahb_master_config#(AHB_ADDR_WIDTH,AHB_DATA_WIDTH))::get(this, "", "master_config_object", config_db))
    begin
        `uvm_fatal(get_type_name(), "The Configuration Object for the monitor has not been set.")
    end

endfunction: build_phase


// Define the connect phase of the UVM Monitor.
function void ahb_master_monitor::connect_phase(uvm_phase phase);

    super.connect_phase(phase);

    `uvm_info(get_type_name(), "Inside the Connect Phase of ahb_master_monitor.", UVM_HIGH)

    vif = config_db.vif;

endfunction: connect_phase


// Define the run phase of the UVM Monitor.
task ahb_master_monitor::run_phase(uvm_phase phase);

    super.run_phase(phase);

    `uvm_info(get_type_name(), "Inside the Run Phase of ahb_master_monitor.", UVM_HIGH)

    // Please put your logic here....
	
	// Hint : Should use a state machine to monitor the bit toggling at the
	// interface and create a high level instruction and then broadcast it


endtask : run_phase


`endif
