////----------------------------------------------------------------------
//// This file has been automatically generated by
//// VerifStudio Software Version 0.63, Accelver Systems Inc.
//// Any modifications that you make to this file may be
//// overwritten by the tool when regenerating the files. 
////----------------------------------------------------------------------

`ifndef AHB_REG_ADAPTER__SV
`define AHB_REG_ADAPTER__SV

class ahb_reg_adapter#(AHB_ADDR_WIDTH=16,AHB_DATA_WIDTH=16) extends uvm_reg_adapter;

    // Register the class ahb_reg_adapter with the factory.
    `uvm_object_param_utils(ahb_reg_adapter#(AHB_ADDR_WIDTH,AHB_DATA_WIDTH))

    // The Constructor for this Class.
    function new(string name="ahb_reg_adapter");
        super.new(name);

        // Set the provides_responses bit based on whether driver is sending back response to sequencer.
        provides_responses = 1'b1;
    endfunction: new

    // Function that converts the register transaction to bus-level transaction.
    virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);

        // Create an transaction object for the protocol ahb.
        ahb_master_transaction#(AHB_ADDR_WIDTH,AHB_DATA_WIDTH) ahb_trans = ahb_master_transaction#(AHB_ADDR_WIDTH,AHB_DATA_WIDTH)::type_id::create("ahb_trans");

        // TO BE FIXED: Write the logic to do the convertion between reg and bus transactions.

        // Return the created ahb transaction object.
        return ahb_trans;

    endfunction: reg2bus


    // Function that converts the bus-level transaction to register transaction.
    virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);

        // Declare a handle to the transaction object for the protocol ahb.
        ahb_master_transaction#(AHB_ADDR_WIDTH,AHB_DATA_WIDTH) ahb_trans;

        // Cast the bus-transaction with the bus_item we got as an input argument.
        if(!$cast(ahb_trans, bus_item))
        begin
            `uvm_fatal(get_type_name(), "Provided bus_item is not of ahb transaction type")
            return;
        end

        // TO BE FIXED: Write the logic to do the convertion between bus and reg transactions.

    endfunction: bus2reg


endclass: ahb_reg_adapter


`endif