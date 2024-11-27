`ifndef AHB_TRANSACTION__SV
`define AHB_TRANSACTION__SV

class ahb_transaction #( ADDR_WIDTH=32, DATA_WIDTH=32 ) extends uvm_sequence_item;
	
	rand bit [ADDR_WIDTH-1:0] 		m_address;
	rand ahb_read_write_enum 		m_read_write;
	rand bit [DATA_WIDTH-1:0]		m_wdata;
	rand bit [DATA_WIDTH-1:0] 		m_rdata;
	rand ahb_response_type_enum		m_response_type;

`uvm_object_param_utils_begin
	`uvm_field_int	(m_address,					UVM_ALL_ON)
	`uvm_field_int	(m_wdata,					UVM_ALL_ON)
	`uvm_field_int	(m_rdata,					UVM_ALL_ON)
	`uvm_field_enum	(ahb_read_write_enum, m_read_write, 		UVM_ALL_ON)
	`uvm_field_enum	(ahb_response_type_enum, m_response_type, 	UVM_ALL_ON)
`uvm_object_param_utils_end

constraint c_address { m_address >= 0;}

endclass : ahb_transaction
`endif

