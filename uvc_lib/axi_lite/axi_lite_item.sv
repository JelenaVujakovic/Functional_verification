//------------------------------------------------------------------------------
// Copyright (c) 2020 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : axi_lite_item.sv
// Developer  : Jelena Vujakovic
// Date       : Aug 8, 2020
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef AXI_LITE_ITEM_SV
`define AXI_LITE_ITEM_SV

class axi_lite_item extends uvm_sequence_item;
  
  // item fields
  rand bit m_signal_value;
  
  // registration macro    
  `uvm_object_utils_begin(axi_lite_item)
    `uvm_field_int(m_signal_value, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constraints
  constraint m_signal_value_c {
    soft m_signal_value == 1;
  }
  
  // constructor  
  extern function new(string name = "axi_lite_item");
  
endclass : axi_lite_item

// constructor
function axi_lite_item::new(string name = "axi_lite_item");
  super.new(name);
endfunction : new

`endif // AXI_LITE_ITEM_SV
