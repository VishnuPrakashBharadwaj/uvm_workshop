// A simple counter with two interfaces
//  configuration - SRAM like interface
//  data_out - current count
//


// As Defined in the AHB Reference manual.

`include "pcounter.sv"

import ahb_enum_types_pkg::*;


module pcounter_ahb_wrapper ( 

        input   logic               hclk,
        input   logic               hreset_n,
        input   logic               hready_in,
        input   logic[31:0]         haddr,
        input   logic[31:0]         hwdata, 
        output  logic[31:0]         hrdata, 
        input   logic               hwrite,
        output  ahb_hresp_enum      hresp,
        input   ahb_htrans_enum     htrans, 
        input   ahb_hburst_enum     hburst, 
        input   ahb_hsize_enum      hsize,  // Only hsize of WORD is supported.
        output  logic               hready,
        input   logic               hsel,
        input   logic[3:0]          hprot  // Protection bits not supported.
    );

    reg [31:0] 	dut_wdata_sig;
    reg [31:0] 	dut_addr_sig;
    reg [31:0]  dut_rdata_sig;
    reg         dut_wenable_sig;
    reg         dut_renable_sig;
    reg         cfg_enable_sig;
    reg         tmp_count;

    typedef enum bit[1:0] {ST_READ, ST_WRITE, ST_RESET} states_e;  

    // Declare two variables called p_state and n_state of
    // type states_e
  
    states_e   p_state;
    states_e   n_state;

    // State transition at each posedge of clk
    // If reset is active then state is reset to
    // Reset state; 
    always @(posedge hclk or negedge hreset_n)
    begin
	if (!hreset_n)
	begin
            p_state <= ST_RESET;
	    n_state <= ST_RESET;
            cfg_enable_sig <= 0;
	end
	else if (hready_in)
	begin
            p_state <= n_state;
	    dut_addr_sig  <= haddr;
	end	
    end

    // Current state output signals.
    // Populate the dut output ports based on the current
    // state value.
   
    always @(*)
    begin
        dut_wenable_sig <= 0;
	dut_renable_sig <= 0;

        // If current state is a write state and the 
        // ready signal is active, setup the write on dut
	if ((p_state == ST_WRITE) && (hready_in))
	begin
            dut_wdata_sig   <= hwdata;
	    dut_wenable_sig <= 1;
	    dut_renable_sig <= 0;
	end

       // If current state is a read state and the 
        // ready signal is active, setup the read

	if ((p_state == ST_READ) && (hready_in))
	begin
	    dut_wenable_sig <= 0;
	    dut_renable_sig <= 1;
	end	  

    end

    always @(negedge hclk)
    begin
        if(htrans == NONSEQ)
        begin
            cfg_enable_sig <= 1;
            tmp_count <= 1;
        end

        else if(htrans == IDLE && tmp_count == 0)
        begin
            cfg_enable_sig <= 0;
        end

        else
        begin
            tmp_count <= 0;
        end
    end

    // Complete the case statement to compute the next_state logic
  
    // CurrentState    NextState         ConditionForTransition
    //---------------------------------------------------------
    // ST_RESET          ST_WRITE       hwrite && hready_in && hreset_n
    // ST_RESET          ST_READ       (! hwrite) && hready_in && hreset_n
    // ST_WRITE          ST_WRITE       hwrite && hready_in && hreset_n
    // ST_RESET          ST_READ       (! hwrite) && hready_in && hreset_n
    // ST_READ           ST_WRITE       hwrite && hready_in && hreset_n
    // ST_READ           ST_READ       (! hwrite) && hready_in && hreset_n   
  
   
    always @(*)
    begin
	case (p_state)

	ST_RESET : 
             if ((hwrite) && (hready_in) && (hreset_n) )
             begin
		 n_state = ST_WRITE;
	     end
             else if ( (!(hwrite)) && (hready_in) && (hreset_n)  )
             begin
  		n_state = ST_READ;
             end
             else
	     begin
 		 n_state = ST_RESET;
	     end

       ST_WRITE : if ((hwrite) && (hready_in) && (hreset_n))
	     begin
		 n_state = ST_WRITE;
	     end
	     else if ((!(hwrite)) && (hready_in) && (hreset_n))
             begin
		 n_state = ST_READ;
	     end
	     else
	     begin
	 	n_state = ST_WRITE;
	     end

       ST_READ : if ((!(hwrite)) && (hready_in) && (hreset_n))
	     begin
		n_state = ST_READ;
	     end
	     else if ((hwrite) && (hready_in) && (hreset_n))
	     begin
		n_state = ST_WRITE;
	     end
	     else
	     begin
		n_state = ST_READ;
	     end
	endcase
    end
    assign hrdata = dut_rdata_sig;
    //assign hrdata[31:10] = 'b0;


    // Connect the pcounter DUT with the AHB Interface.
    pcounter pcounter_i 
    (
       .clk(hclk),
       .rst(hreset_n),
       .cfg_wdata(dut_wdata_sig),
       .cfg_rdata(dut_rdata_sig),
       .cfg_addr(haddr[4:0]),
       .cfg_rd_wr(~hwrite),
       .cfg_enable(cfg_enable_sig),
       .counter_o(),
       .curr_state_o()
    );   

    initial
    begin
        hresp = OKAY;
        hready = 1;
    end


    //always @(posedge hclk)
    //begin
    //    hready <= $urandom_range(0,1);
    //end

endmodule //pcounter_wrapper
