`ifndef AXI_LITE_WRITE_START_REGISTER_VALUE_SEQ_SV
`define AXI_LITE_WRITE_START_REGISTER_VALUE_SEQ_SV


class axi_lite_write_start_register_value_seq extends axi_lite_basic_seq;
  
  // registration macro
  `uvm_object_utils(axi_lite_write_start_register_value_seq)

  rand bit [3:0] addr;
  rand bit [31:0] data;
  rand rw_operation rw_op;

   // constraint
  constraint read_op_c { rw_op == write;};
  constraint start_register_address_c { addr == START_REGISTER; }
  

  // constructor
  function new(string name = "axi_lite_write_start_register_value_seq");
   super.new(name);
  endfunction : new
  // body task
  task body();

  req = axi_lite_item::type_id::create("req");
  
  start_item(req);
  
  if(!req.randomize() with {addr == local::addr; data == local::data; rw_op == local::rw_op; }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end  
  
  finish_item(req);

endtask : body
  
endclass : axi_lite_write_start_register_value_seq

`endif
//-testplusarg UVM_TESTNAME=test_scrambler_ip_example -testplusarg UVM_VERBOSITY=UVM_LOW
