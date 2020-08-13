`ifndef AXI_LITE_WRITE_SEQ_SV
`define AXI_LITE_WRITE_SEQ_SV


class axi_lite_write_seq extends axi_lite_basic_seq;
  
  // registration macro
  `uvm_object_utils(axi_lite_write_seq)
  
  // constructor
  function new(string name = "axi_lite_write_seq");
   super.new(name);
  endfunction : new
  // body task
  task body();

  req = axi_lite_item::type_id::create("req");
  
  start_item(req);
  
  if(!req.randomize() with {write == 1; read == 0; addr == local::addr; data == local::data;}) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end  
  
  finish_item(req);

endtask : body
  
endclass : axi_lite_write_seq

`endif
