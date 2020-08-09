//------------------------------------------------------------------------------
// Copyright (c) 2020 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : bram_b_cov.sv
// Developer  : Jelena Vujakovic
// Date       : Aug 8, 2020
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef BRAM_B_COV_SV
`define BRAM_B_COV_SV

class bram_b_cov extends uvm_subscriber #(bram_b_item);
  
  // registration macro
  `uvm_component_utils(bram_b_cov)
  
  // configuration reference
  bram_b_agent_cfg m_cfg;
  
  // coverage fields 
  bit m_signal_value_cov;
  
  // coverage groups
  covergroup bram_b_cg;
    option.per_instance = 1;

    cp_signal_value : coverpoint m_signal_value_cov {
      //option.weight = 0;
    }
  endgroup : bram_b_cg
  
  // constructor
  extern function new(string name, uvm_component parent);
  // analysis implementation port function
  extern virtual function void write(bram_b_item t);

endclass : bram_b_cov

// constructor
function bram_b_cov::new(string name, uvm_component parent);
  super.new(name, parent);
  bram_b_cg = new();
endfunction : new

// analysis implementation port function
function void bram_b_cov::write(bram_b_item t);
  m_signal_value_cov = t.m_signal_value;
  bram_b_cg.sample();
endfunction : write

`endif // BRAM_B_COV_SV
