`ifndef BRAM_A_COVERAGE_SV
`define BRAM_A_COVERAGE_SV

class bram_a_coverage extends uvm_subscriber #(bram_a_item);
  
  // registration macro
  `uvm_component_utils(bram_a_coverage)
  
  // configuration reference
  bram_a_agent_cfg m_cfg;
  
  // coverage fields 
   bit [31:0] input_data_cov;
   int number_of_bram_a_data_cov;
   bram_a_item bram_a_clone_item;

  // coverage groups
  covergroup bram_a_cg @(posedge bram_a_clone_item.m_ena);
    option.per_instance = 1;

    //Cover randomization of data
    bram_a_data: coverpoint bram_a_clone_item.m_input_data {
        bins low = { [0:500] };
        bins med = { [501:1000] };
        bins high = { [1001:1499] };
    }
    //Cover different address range
    bram_a_address: coverpoint bram_a_clone_item.m_address {
        bins low_addr_range = { [0:10921] };
        bins med_addr_range = { [10922:21842] };
        bins high_addr_range = { [21843:32764] };
    }
    cross_bram_a_addr_and_data: cross bram_a_clone_item.m_address,bram_a_clone_item.m_input_data;
    
  endgroup : bram_a_cg
  
  // constructor
  extern function new(string name, uvm_component parent);
  // analysis implementation port function
  extern virtual function void write(bram_a_item t);

endclass : bram_a_coverage

// constructor
function bram_a_coverage::new(string name, uvm_component parent);
  super.new(name, parent);
  bram_a_cg = new();
endfunction : new

// analysis implementation port function
function void bram_a_coverage::write(bram_a_item t);
  $cast(bram_a_clone_item,t.clone());
     number_of_bram_a_data_cov = bram_a_clone_item.m_input_data;
     number_of_bram_a_data_cov++;
	 bram_a_cg.sample();
endfunction : write
`endif 
