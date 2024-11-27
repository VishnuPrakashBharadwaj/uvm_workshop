`ifndef AHB_ENUM_TYPES__SV
`define AHB_ENUM_TYPES__SV

package ahb_enum_types;
	typedef enum bit		{ AHB_READ=1'b0, AHB_WRITE=1'b1 } ahb_read_write_enum;
	typedef enum bit[1:0]	{ AHB_OKAY=2'b00, AHB_ERROR=2'b01, AHB_RETRY=2'b10, AHB_SPLIT=2'b11} ahb_response_type_enum;
endpackage

`endif
