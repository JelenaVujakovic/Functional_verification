`ifndef AXI_LITE_BASIC_SEQ_SV
`define AXI_LITE_BASIC_SEQ_SV

class axi_lite_basic_seq extends uvm_sequence #(axi_lite_item);
  
  // registration macro
  `uvm_object_utils(axi_lite_basic_seq)
  
  // sequencer pointer macro
  `uvm_declare_p_sequencer(axi_lite_sequencer)
  
  // fields
  rand bit m_signal_value;
  
  // constraints
  constraint m_signal_value_c {
    soft m_signal_value == 1;
  }
  
  // constructor
  extern function new(string name = "axi_lite_basic_seq");
  // body task
  extern virtual task body();

endclass : axi_lite_basic_seq

// constructor
function axi_lite_basic_seq::new(string name = "axi_lite_basic_seq");
  super.new(name);
endfunction : new

// body task
task axi_lite_basic_seq::body();
  `uvm_info(get_type_name(), $sformatf("Sequence axi_lite_basic_seq : set signal to %0d", m_signal_value), UVM_HIGH)
  
  //--------------------------------------------------
  req = axi_lite_item::type_id::create("req");
  
  start_item(req);
  
  if(!req.randomize() with {
    m_signal_value == local::m_signal_value;
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end  
  
  finish_item(req);
  //--------------------------------------------------
  // or
  //--------------------------------------------------
//  `uvm_do_with(req, 
//              {
//               req.m_signal_value == local::m_signal_value;
//              }
//  )
  //--------------------------------------------------
endtask : body

`endif // AXI_LITE_BASIC_SEQ_SV
