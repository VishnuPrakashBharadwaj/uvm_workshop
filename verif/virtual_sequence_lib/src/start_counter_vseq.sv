////----------------------------------------------------------------------
//// This file has been automatically generated by
//// VerifStudio Software Version 0.63, Accelver Systems Inc.
//// Any modifications that you make to this file may be
//// overwritten by the tool when regenerating the files. 
////----------------------------------------------------------------------

`ifndef START_COUNTER_VSEQ__SV
`define START_COUNTER_VSEQ__SV

class start_counter_vseq extends uvm_sequence#( uvm_sequence_item );

    // Register the class start_counter_vseq with the factory.
    `uvm_object_utils(start_counter_vseq)

    // Set the handle to the virtual sequencer.
    `uvm_declare_p_sequencer(ahb_config_pcounter_virtual_sequencer)

    // The Constructor for this Class.
    function new(string name="start_counter_vseq");
        super.new(name);
    endfunction: new

    // Declare the body of the Sequence
    extern task body();

    extern task exec_basic_block_0();

endclass: start_counter_vseq


task start_counter_vseq::body();

    exec_basic_block_0();

endtask : body


task start_counter_vseq::exec_basic_block_0();

    begin

        // Declare the lower level Sequences that are used inside this Sequence
    	//Fix me: Please Put your logic here

        // Create the lower level Sequence objects used.
    	//Fix me: Please Put your logic here

        // Randomize the lower level sequences with their constriants
    	//Fix me: Please Put your logic here
        if(/*call randomization with `AHB_CONFIG_PCOUNTER_BASE_ADDR */)
        begin
            `uvm_fatal(get_type_name(), "[RAND_FAILED]: Randomization failed due to violation of transaction constraints.")
        end

        // Start the Sub-Sequences on a sequencer.
    	//Fix me: Please Put your logic here

    end

endtask : exec_basic_block_0



`endif