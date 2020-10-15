`ifndef SCRAMBLER_IP_TOP_CFG_SV
`define SCRAMBLER_IP_TOP_CFG_SV

class scrambler_ip_top_cfg extends uvm_object;
    
  // UVC configuration
   axi_lite_cfg m_axi_lite_cfg;
   bram_a_cfg m_bram_a_cfg;
   bram_b_cfg m_bram_b_cfg;
  
  // registration macro
  `uvm_object_utils_begin(scrambler_ip_top_cfg)
    `uvm_field_object(m_axi_lite_cfg, UVM_ALL_ON)
    `uvm_field_object(m_bram_a_cfg, UVM_ALL_ON)
    `uvm_field_object(m_bram_b_cfg, UVM_ALL_ON)
  `uvm_object_utils_end
    
  // constructor
  extern function new(string name = "scrambler_ip_top_cfg");
  
endclass : scrambler_ip_top_cfg

// constructor
function scrambler_ip_top_cfg::new(string name = "scrambler_ip_top_cfg");
  super.new(name);
  
  // create UVC configuration
  m_axi_lite_cfg = axi_lite_cfg::type_id::create("m_axi_lite_cfg");
  m_bram_a_cfg = bram_a_cfg::type_id::create("m_bram_a_cfg");
  m_bram_b_cfg = bram_b_cfg::type_id::create("m_bram_b_cfg");

endfunction : new

`endif // SCRAMBLER_IP_TOP_CFG_SV
