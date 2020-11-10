`ifndef BRAM_A_BASIC_SEQ_SV
`define BRAM_A_BASIC_SEQ_SV

class bram_a_basic_seq extends uvm_sequence #(bram_a_item);
  
  // registration macro
  `uvm_object_utils(bram_a_basic_seq)
  
  // sequencer pointer macro
  `uvm_declare_p_sequencer(bram_a_sequencer)
  
  // fields
  rand bit [31:0] m_input_data;
  
  //constaints
 
  // constructor
  extern function new(string name = "bram_a_basic_seq");
  // body task
  extern virtual task body();

endclass : bram_a_basic_seq

// constructor
function bram_a_basic_seq::new(string name = "bram_a_basic_seq");
  super.new(name);
endfunction : new

// body task
task bram_a_basic_seq::body();

  req = bram_a_item::type_id::create("req");
  
  start_item(req);
  `uvm_info(get_type_name(), " --- BRAM A basic sequence--- ", UVM_LOW)
  
  if(!req.randomize() with {m_input_data == m_input_data;}) 
  begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end  
  finish_item(req);

endtask : body

`endif // BRAM_A_BASIC_SEQ_SV
