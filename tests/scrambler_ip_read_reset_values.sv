`ifndef TEST_SCRAMBLER_IP_READ_RESET_VALUES_SV
`define TEST_SCRAMBLER_IP_READ_RESET_VALUES_SV

// reset_values test
class test_scrambler_ip_read_reset_values extends test_scrambler_ip_base;
  
  // registration macro
  `uvm_component_utils(test_scrambler_ip_read_reset_values)
 
 
  // constructor
  extern function new(string name, uvm_component parent);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
   // set default configuration
  extern function void set_default_configuration();
  
endclass : test_scrambler_ip_read_reset_values

// constructor
function test_scrambler_ip_read_reset_values::new(string name, uvm_component parent);
  super.new(name, parent);
  
endfunction : new

// run phase
task test_scrambler_ip_read_reset_values::run_phase(uvm_phase phase);
  super.run_phase(phase);

  uvm_test_done.raise_objection(this, get_type_name());   
 
  `uvm_info(get_type_name(), "TEST STARTED", UVM_LOW)
 
  
     
  uvm_test_done.drop_objection(this, get_type_name());    
  `uvm_info(get_type_name(), "TEST FINISHED", UVM_LOW)
endtask : run_phase

// set default configuration
function void test_scrambler_ip_read_reset_values::set_default_configuration();
  super.set_default_configuration();
  //m_cfg.reset_happend = 1;
  // redefine configuration
endfunction : set_default_configuration

`endif 
