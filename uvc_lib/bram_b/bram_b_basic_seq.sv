//------------------------------------------------------------------------------
// Copyright (c) 2020 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : bram_b_basic_seq.sv
// Developer  : Jelena Vujakovic
// Date       : Aug 8, 2020
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef BRAM_B_BASIC_SEQ_SV
`define BRAM_B_BASIC_SEQ_SV

class bram_b_basic_seq extends uvm_sequence #(bram_b_item);
  
  // registration macro
  `uvm_object_utils(bram_b_basic_seq)
  
  // sequencer pointer macro
  `uvm_declare_p_sequencer(bram_b_sequencer)
  
  // fields
  rand bit m_signal_value;
  
  // constraints
  constraint m_signal_value_c {
    soft m_signal_value == 1;
  }
  
  // constructor
  extern function new(string name = "bram_b_basic_seq");
  // body task
  extern virtual task body();

endclass : bram_b_basic_seq

// constructor
function bram_b_basic_seq::new(string name = "bram_b_basic_seq");
  super.new(name);
endfunction : new

// body task
task bram_b_basic_seq::body();
  `uvm_info(get_type_name(), $sformatf("Sequence bram_b_basic_seq : set signal to %0d", m_signal_value), UVM_HIGH)
  
  //--------------------------------------------------
  req = bram_b_item::type_id::create("req");
  
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

`endif // BRAM_B_BASIC_SEQ_SV
