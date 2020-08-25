`ifndef AXI_LITE_READ_READY_REGISTER_SEQ_SV
`define AXI_LITE_READ_READY_REGISTER_SEQ_SV


class axi_lite_read_ready_register_seq extends axi_lite_basic_seq;
  
  // registration macro
  `uvm_object_utils(axi_lite_read_ready_register_seq)

  rand bit [3:0] addr;
  rand bit [31:0] data;
  rand rw_operation rw_op;

  // constraint
  constraint read_op_c { rw_op == read;};
  constraint ready_register_address_c { addr == READY_REGISTER; }
  // constructor
  function new(string name = "axi_lite_read_ready_register_seq");
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
  
endclass : axi_lite_read_ready_register_seq
`endif
