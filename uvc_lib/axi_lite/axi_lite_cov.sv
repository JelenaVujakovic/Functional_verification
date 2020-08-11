//------------------------------------------------------------------------------
// Copyright (c) 2020 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : axi_lite_cov.sv
// Developer  : Jelena Vujakovic
// Date       : Aug 8, 2020
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef AXI_LITE_COV_SV
`define AXI_LITE_COV_SV

class axi_lite_cov extends uvm_subscriber #(axi_lite_item);
  
  // registration macro
  `uvm_component_utils(axi_lite_cov)
  
  // configuration reference
  axi_lite_agent_cfg m_cfg;
  
  // coverage fields 
  bit m_signal_value_cov;
  
  // coverage groups
  covergroup axi_lite_cg;
    option.per_instance = 1;

    cp_signal_value : coverpoint m_signal_value_cov {
      //option.weight = 0;
    }
  endgroup : axi_lite_cg
  
  // constructor
  extern function new(string name, uvm_component parent);
  // analysis implementation port function
  extern virtual function void write(axi_lite_item t);

endclass : axi_lite_cov

// constructor
function axi_lite_cov::new(string name, uvm_component parent);
  super.new(name, parent);
  axi_lite_cg = new();
endfunction : new

// analysis implementation port function
function void axi_lite_cov::write(axi_lite_item t);
  m_signal_value_cov = t.m_signal_value;
  axi_lite_cg.sample();
endfunction : write

`endif // AXI_LITE_COV_SV
