// A simple counter with two interfaces
//  configuration - SRAM like interface
//  data_out - current count
//

//`timescale 1ns/1ps


module pcounter (// Clocks / Reset
  input         clk,
  input         rst,
  // Configuration Interface - SRAM like
  input         cfg_enable, 
  input         cfg_rd_wr,   // rd = 1, wr = 0
  input  [4:0]  cfg_addr,    // address
  input  [31:0]  cfg_wdata,   // write data
  output [31:0]  cfg_rdata,   // read data
  // Counter output
  output  [31:0]  counter_o,
  output  [1:0]  curr_state_o
);
// pragma attribute pcounter_int partition_module_xrtl  
   // Typedefs
  typedef enum 	 logic[1:0] { CFG_COUNT_UP, CFG_COUNT_DOWN, CFG_SUSPEND } cfg_e;

   // Signal Declaration
  logic [31:0] 	 csr_dir;  // count up or down
  logic [31:0] 	 csr_min;  // min value
  logic [31:0] 	 csr_max;  // max value
  logic [31:0] 	 csr_step; // step
  
  logic [31:0] 	 count ;

  logic [1:0] 	 curr_state;
  logic [1:0] 	 next_state;
  logic [31:0] 	 rdata;
  logic          rollover_status;
  logic          rollover_enable;
  logic          start_counter;

  // Assign Local to Outputs
  assign counter_o = count;
  assign curr_state_o = curr_state;
  assign cfg_rdata = rdata;
   

   // CFG Interface FSM - just to have an FSM in the design
  always_comb begin
      
    case (csr_dir)
      2'b00: begin
	next_state = CFG_COUNT_UP;
      end
      2'b01:  begin
        next_state = CFG_COUNT_DOWN;
      end
      2'b10:  begin
	next_state = CFG_SUSPEND;
      end
      default: begin
	next_state = CFG_COUNT_UP;
      end
    endcase
  end


  always @(posedge clk) begin
    
    if(!rst) begin
      csr_dir <= 0;  //count up 
      csr_min <= 2; // min value
      csr_max <= 50;  //max_value
      csr_step <= 1;  //max_value
      count <= csr_min;  
      rollover_enable <= 1;
      rollover_status <= 0;
      start_counter   <= 0;
    end
    else begin
       
      curr_state = next_state;

      //Update registers for read and Updte 
      if(cfg_enable) begin	// Set cfg_enable = 1 for reading and writing registers
	if(cfg_rd_wr) begin   // Reading data from internal registers
	  case (cfg_addr)
	    5'b00000: begin
	      rdata <= csr_dir;
	      $display("Reading  CSR_DIR register (value = %3d)", rdata);	      
	    end
	    5'b00100: begin
	      rdata <= csr_min;
	      $display("Reading  CSR_MIN register (value = %3d)", rdata);	      	      
	    end
	    5'b01000: begin
	      rdata <= csr_max;
	      $display("Reading  CSR_MAX register (value = %3d)", rdata);	      	      
	    end	    
	    5'b01100: begin
	      rdata <= csr_step;
	      $display("Reading  CSR_STEP register (value = %3d)", rdata);	      	      
	    end	    
	    5'b10000: begin
	      rdata <= rollover_status;
	      $display("Reading  ROLLOVER_STATUS register (value = %3d)", rdata);	      	      
	    end 
	    5'b10100: begin
	      rdata <= count;
	      $display("Reading  COUNT register (value = %3d)", rdata);	      	      
	    end 
	    5'b11000: begin
	      rdata <= rollover_enable;
	      $display("Reading  ROLLOVER_ENABLE register (value = %3d)", rdata);	      	      
	    end 
	    5'b11100: begin
	      rdata <= start_counter;
	      $display("Reading  START_COUNTER register (value = %3d)", rdata);	      	      
	    end 
	  endcase // case (cfg_addr)
	end // if (cfg_rd_wr)
	else begin         // Writing data to registers
	  case (cfg_addr)
	    5'b00000: begin
	      csr_dir <= cfg_wdata;
	      $display("Wrote CSR_DIR register with %3d", cfg_wdata);
	    end
	    5'b00100: begin
	      csr_min <= cfg_wdata;
              count <= cfg_wdata;
	      $display("Wrote CSR_MIN register with %3d", cfg_wdata);	      
	    end
	    5'b01000: begin
	      csr_max <= cfg_wdata ;
	      $display("Wrote CSR_MAX register with %3d", cfg_wdata);	      	      
	    end	    
	    5'b01100: begin
	      csr_step <= cfg_wdata;
	      $display("Wrote CSR_STEP register with %3d", cfg_wdata);	      	      	      
	    end	    
	    5'b10000: begin
	      $display("Cannot Write into ROLLOVER_STATUS register");
	    end 
	    5'b10100: begin
	      $display("Cannot Write COUNT register");	      	      
	    end 
	    5'b11000: begin
              rollover_enable <= cfg_wdata;
	      $display("Wrote ROLLOVER_ENABLE register with %3d", cfg_wdata);	      	      
	    end 
	    5'b11100: begin
              start_counter <= cfg_wdata;
	      $display("Wrote START_COUNTER register with %3d", cfg_wdata);	      	      
	    end 
	  endcase // case (cfg_addr)
	end // else: !if(cfg_rd_wr)
      end // if (cfg_enable)
      
      else if(start_counter) begin
        case (csr_dir) 
          2'b00: begin
            if(count >= csr_max) begin
              count <= csr_min;	
              rollover_status <= 1;
            end
            else begin  
              count <= count + csr_step;
              rollover_status <= 0;
            end
          end
     
          2'b01: begin
            if(count <= csr_min) begin	
              count <= csr_max;
              rollover_status <= 1;
            end	
            else begin
              count <= count - csr_step;
              rollover_status <= 0;
            end
           end

          default: begin
          end
          
        endcase // case csr_dir)
        $display("(%6d) Count value =  %d", $time(), count);
      end // if(start_counter)
    end // else: !if(~rst)
  end // always @ (posedge clk)
endmodule

