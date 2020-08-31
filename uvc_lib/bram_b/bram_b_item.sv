`ifndef BRAM_B_ITEM_SV
`define BRAM_B_ITEM_SV

class bram_b_item extends uvm_sequence_item;
  
  // item fields
  rand bit [31:0] m_data_b_out;
  rand bit [31:0] m_addr_b_out;
  
  // registration macro    
  `uvm_object_utils_begin(bram_b_item)
    `uvm_field_int(m_data_b_out, UVM_ALL_ON)
    `uvm_field_int(m_addr_b_out, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constraints
  constraint m_data_b_out_c {
    m_data_b_out < 1500; 
  }
  constraint m_addr_b_out_c {
    m_addr_b_out % 4 == 0; 
  }
  
  
  // constructor  
  extern function new(string name = "bram_b_item");
  
endclass : bram_b_item

// constructor
function bram_b_item::new(string name = "bram_b_item");
  super.new(name);
endfunction : new

`endif // BRAM_B_ITEM_SV
