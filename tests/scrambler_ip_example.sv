`ifndef TEST_SCRAMBLER_IP_EXAMPLE_SV
`define TEST_SCRAMBLER_IP_EXAMPLE_SV

// example test
class test_scrambler_ip_example extends test_scrambler_ip_base;
  
  // registration macro
  `uvm_component_utils(test_scrambler_ip_example)
  


  // constructor
  extern function new(string name, uvm_component parent);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // set default configuration
  extern function void set_default_configuration();
  
endclass : test_scrambler_ip_example

// constructor
function test_scrambler_ip_example::new(string name, uvm_component parent);
  super.new(name, parent);

endfunction : new

// run phase
task test_scrambler_ip_example::run_phase(uvm_phase phase);
  super.run_phase(phase);
  
  uvm_test_done.raise_objection(this, get_type_name());    
  `uvm_info(get_type_name(), "TEST STARTED", UVM_LOW)
 

 
     
  uvm_test_done.drop_objection(this, get_type_name());    
  `uvm_info(get_type_name(), "TEST FINISHED", UVM_LOW)
endtask : run_phase

// set default configuration
function void test_scrambler_ip_example::set_default_configuration();
  super.set_default_configuration();
  
  // redefine configuration
endfunction : set_default_configuration

`endif // TEST_SCRAMBLER_IP_EXAMPLE_SV
