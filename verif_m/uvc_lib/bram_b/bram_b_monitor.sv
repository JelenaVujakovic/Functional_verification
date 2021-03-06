`ifndef BRAM_B_MONITOR_SV
`define BRAM_B_MONITOR_SV

class bram_b_monitor extends uvm_monitor;
  
  // registration macro
  `uvm_component_utils(bram_b_monitor)
  
  // analysis port
  uvm_analysis_port #(bram_b_item) m_aport;
  
  // virtual interface reference
  virtual interface bram_b_if m_vif;
  
  // configuration reference
  bram_b_agent_cfg m_cfg;
  
  // monitor item
  bram_b_item m_item;
  
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // handle reset
  extern virtual task handle_reset();
  // collect item
  extern virtual task collect_item();

endclass : bram_b_monitor

// constructor
function bram_b_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void bram_b_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  // create port
  m_aport = new("m_aport", this);
  
  // create item
  m_item = bram_b_item::type_id::create("m_item", this);
endfunction : build_phase

// connect phase
task bram_b_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  
  forever begin
    fork : run_phase_fork_block
      begin
        handle_reset();
      end
      begin
        collect_item();    
      end
    join_any // run_phase_fork_block
    disable fork;
  end

endtask : run_phase

// handle reset
task bram_b_monitor::handle_reset();
  // wait reset assertion
  @(m_vif.reset_n iff m_vif.reset_n == 0);
  `uvm_info(get_type_name(), "Reset asserted.", UVM_HIGH)
endtask : handle_reset

// collect item
task bram_b_monitor::collect_item();  
  // wait until reset is de-asserted
  wait (m_vif.reset_n == 1);
  `uvm_info(get_type_name(), "Reset de-asserted. Starting to collect items...", UVM_HIGH)
  
  forever begin    
    
     @(posedge m_vif.clock iff m_vif.web=== 1'b1); 
     m_item.m_addr_b_out = m_vif.addrb; 
     m_item.m_data_b_out = m_vif.data_b_out; 
     m_item.m_wr_en= m_vif.web;
    
   //print item
   `uvm_info(get_type_name(), $sformatf("Address of B is: %d, data is : %d", m_item.m_addr_b_out, m_item.m_data_b_out), UVM_INFO)
    // write analysis port
    m_aport.write(m_item);   
  end 
endtask : collect_item

`endif // BRAM_B_MONITOR_SV
