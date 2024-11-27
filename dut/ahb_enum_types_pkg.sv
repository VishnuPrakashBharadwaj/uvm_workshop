`ifndef AHB_ENUM_TYPES__SV
`define AHB_ENUM_TYPES__SV

package ahb_enum_types_pkg;

    typedef enum bit [1:0] { READ=2'b00, WRITE=2'b01, NOP=2'b11 } ahb_read_write_enum;
    
    typedef enum bit [1:0] { IDLE=2'b00, BUSY=2'b01, NONSEQ=2'b10, SEQ=2'b11 } ahb_htrans_enum;

    typedef enum bit [1:0] { OKAY=2'b00, ERROR=2'b01, RETRY=2'b10, SPLIT=2'b11 } ahb_hresp_enum;

    typedef enum bit [2:0] { SINGLE=3'b000, INCR=3'b001, WRAP4=3'b010, INCR4=3'b011, WRAP8=3'b100, INCR8=3'b101, WRAP16=3'b110, INCR16=3'b111 } ahb_hburst_enum;

    typedef enum bit [2:0] { BYTE=3'b000, HALF_WORD=3'b001, WORD=3'b010, DOUBLE_WORD=3'b011, FOUR_WORD=3'b100, EIGHT_WORD=3'b101, SIXTEEN_WORD=3'b110, THIRTYTWO_WORD=3'b111 } ahb_hsize_enum;

endpackage : ahb_enum_types_pkg

`endif
