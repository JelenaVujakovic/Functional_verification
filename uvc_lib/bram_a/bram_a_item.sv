`ifndef BRAM_A_ITEM_SV
`define BRAM_A_ITEM_SV

class bram_a_item extends uvm_sequence_item;
  
   // item fields
  rand bit [31:0] m_input_data;
  bit [31:0] m_address;

  //output
  bit m_ena;
  
  // registration macro    
  `uvm_object_utils_begin(bram_a_item)
    `uvm_field_int(m_input_data, UVM_ALL_ON)
    `uvm_field_int(m_address, UVM_ALL_ON)
    `uvm_field_int(m_ena, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constraints
  constraint m_address_c {
    m_address % 4 == 0;
  }
  constraint m_input_data_c {
    m_input_data < 1500; 
  }
  // constructor  
  extern function new(string name = "bram_a_item");
  
endclass : bram_a_item

// constructor
function bram_a_item::new(string name = "bram_a_item");
  super.new(name);
endfunction : new

`endif // BRAM_A_ITEM_SV    
