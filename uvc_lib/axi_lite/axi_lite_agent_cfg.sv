//------------------------------------------------------------------------------
// Copyright (c) 2020 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : axi_lite_agent_cfg.sv
// Developer  : Jelena Vujakovic
// Date       : Aug 8, 2020
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef AXI_LITE_AGENT_CFG_SV
`define AXI_LITE_AGENT_CFG_SV

class axi_lite_agent_cfg extends uvm_object;
  
  // configuration fields
  uvm_active_passive_enum m_is_active = UVM_ACTIVE;
  bit m_has_checks;
  bit m_has_coverage;  
  byte m_cfg_field;
  
  // registration macro
  `uvm_object_utils_begin(axi_lite_agent_cfg)
    `uvm_field_enum(uvm_active_passive_enum, m_is_active, UVM_ALL_ON)
    `uvm_field_int(m_has_checks, UVM_ALL_ON)
    `uvm_field_int(m_has_coverage, UVM_ALL_ON)
    `uvm_field_int(m_cfg_field, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constructor   
  extern function new(string name = "axi_lite_agent_cfg");
    
endclass : axi_lite_agent_cfg

// constructor
function axi_lite_agent_cfg::new(string name = "axi_lite_agent_cfg");
  super.new(name);
endfunction : new

`endif // AXI_LITE_AGENT_CFG_SV
