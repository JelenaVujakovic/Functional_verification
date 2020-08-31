`ifndef BRAM_B_COVERAGE_SV
`define BRAM_B_COVERAGE_SV

class bram_b_coverage extends uvm_subscriber #(bram_b_item);
  
  // registration macro
  `uvm_component_utils(bram_b_coverage)
  
  // configuration reference
  bram_b_agent_cfg m_cfg;
  
  // coverage fields 
   bit [31:0] data_b_out_cov;
   int number_of_data_b_out_cov;
   bram_b_item bram_b_clone_item;

  // coverage groups
  covergroup bram_b_cg;
    option.per_instance = 1;

    bram_b_data: coverpoint bram_b_clone_item.m_data_b_out {
        bins low = { [0:500] };
        bins med = { [501:1000] };
        bins high = { [1001:1499] };
    }
    //Cover different address range
    bram_b_address: coverpoint bram_b_clone_item.m_addr_b_out {
        bins low_addr_range = { [0:10921] };
        bins med_addr_range = { [10922:21842] };
        bins high_addr_range = { [21843:32764] };
    }
    cross_bram_b_addr_and_data: cross bram_b_clone_item.m_addr_b_out,bram_b_clone_item.m_data_b_out;
   
  endgroup : bram_b_cg
  
  // constructor
  extern function new(string name, uvm_component parent);
  // analysis implementation port function
  extern virtual function void write(bram_b_item t);

endclass : bram_b_coverage

// constructor
function bram_b_coverage::new(string name, uvm_component parent);
  super.new(name, parent);
  bram_b_cg = new();
endfunction : new

// analysis implementation port function
function void bram_b_coverage::write(bram_b_item t);
 $cast(bram_b_clone_item,t.clone());
  data_b_out_cov = bram_b_clone_item.m_data_b_out;
  number_of_data_b_out_cov++;
  bram_b_cg.sample();
endfunction : write

`endif 
