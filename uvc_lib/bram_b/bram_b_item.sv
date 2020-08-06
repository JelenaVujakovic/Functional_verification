`ifndef BRAM_B_ITEM_SV
`define BRAM_B_ITEM_SV

class bram_b_item extends uvm_sequence_item;
  
  // item fields
  rand bit [15:0] m_data_b_out;
  rand bit [31:0] m_addrb;
  bit en_b;
  
  // registration macro    
  `uvm_object_utils_begin(bram_b_item)
    `uvm_field_int(m_data_b_out, UVM_ALL_ON)
    `uvm_field_int(m_addrb, UVM_ALL_ON)
    `uvm_field_int(en_b, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constructor  
  extern function new(string name = "bram_b_item");
  
endclass : bram_b_item

// constructor
function bram_b_item::new(string name = "bram_b_item");
  super.new(name);
endfunction : new

`endif 
