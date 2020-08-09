//------------------------------------------------------------------------------
// Copyright (c) 2020 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : bram_b_item.sv
// Developer  : Jelena Vujakovic
// Date       : Aug 8, 2020
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef BRAM_B_ITEM_SV
`define BRAM_B_ITEM_SV

class bram_b_item extends uvm_sequence_item;
  
  // item fields
  rand bit m_signal_value;
  
  // registration macro    
  `uvm_object_utils_begin(bram_b_item)
    `uvm_field_int(m_signal_value, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constraints
  constraint m_signal_value_c {
    soft m_signal_value == 1;
  }
  
  // constructor  
  extern function new(string name = "bram_b_item");
  
endclass : bram_b_item

// constructor
function bram_b_item::new(string name = "bram_b_item");
  super.new(name);
endfunction : new

`endif // BRAM_B_ITEM_SV
