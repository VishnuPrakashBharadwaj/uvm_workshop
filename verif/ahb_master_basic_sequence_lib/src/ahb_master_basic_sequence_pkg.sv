////----------------------------------------------------------------------
//// This file has been automatically generated by
//// VerifStudio Software Version 0.63, Accelver Systems Inc.
//// Any modifications that you make to this file may be
//// overwritten by the tool when regenerating the files. 
////----------------------------------------------------------------------

`ifndef AHB_MASTER_BASIC_SEQUENCE_PKG__SV
`define AHB_MASTER_BASIC_SEQUENCE_PKG__SV

`include "uvm_macros.svh"

package ahb_master_basic_sequence_pkg;

    import uvm_pkg::*;
    import ahb_enum_types::*;
    import ahb_transaction_pkg::*;
    import ahb_coverage_pkg::*;
    import ahb_master_pkg::*;
    import ahb_slave_pkg::*;
    import vk_mem_pkg::*;

    `include "ahb_write_basic_seq.sv"

endpackage : ahb_master_basic_sequence_pkg

`endif