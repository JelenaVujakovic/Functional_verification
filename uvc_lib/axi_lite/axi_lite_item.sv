`ifndef AXI_LITE_ITEM_SV
`define AXI_LITE_ITEM_SV

class axi_lite_item extends uvm_sequence_item;
  
   // item fields
  rand bit [3:0] addr;
  rand bit [31:0] data;
  rand rw_operation rw_op;

  //output
  // registration macro    
  `uvm_object_utils_begin(axi_lite_item)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_field_enum(rw_operation,rw_op, UVM_ALL_ON)
  `uvm_object_utils_end

  // constraints
  constraint c_addr {
      (addr == 4 || addr == 8);
  }

  // constructor  
  extern function new(string name = "axi_lite_item");
  
endclass : axi_lite_item

// constructor
function axi_lite_item::new(string name = "axi_lite_item");
  super.new(name);
endfunction : new

`endif // AXI_LITE_ITEM_SV
