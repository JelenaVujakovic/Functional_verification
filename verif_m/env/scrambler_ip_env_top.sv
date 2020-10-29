`ifndef SCRAMBLER_IP_ENV_TOP_SV
`define SCRAMBLER_IP_ENV_TOP_SV

class scrambler_ip_env_top extends uvm_env;
  
  // registration macro
  `uvm_component_utils(scrambler_ip_env_top)

  // configuration reference
  scrambler_ip_top_cfg m_cfg;
    
  // component instance
  axi_lite_env m_axi_lite_env;
  bram_a_env m_bram_a_env; 
  bram_b_env m_bram_b_env; 
  
  scrambler_ip_virtual_sequencer m_virt_seqr;
  scrambler_ip_scoreboard m_scoreboard;
  //scrambler_ip_coverage_collector m_coverage;


  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  //connect phase
  extern virtual function void connect_phase(uvm_phase phase);
  
endclass : scrambler_ip_env_top

// constructor
function scrambler_ip_env_top::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void scrambler_ip_env_top::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  // get configuration
  if(!uvm_config_db #(scrambler_ip_top_cfg)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end

  // set configuration
  uvm_config_db#(bram_a_cfg)::set(this, "m_bram_a_env", "m_cfg", m_cfg.m_bram_a_cfg);
  uvm_config_db#(bram_b_cfg)::set(this, "m_bram_b_env", "m_cfg", m_cfg.m_bram_b_cfg);
  uvm_config_db#(axi_lite_cfg)::set(this, "m_axi_lite_env", "m_cfg", m_cfg.m_axi_lite_cfg);

  // create component
  m_axi_lite_env = axi_lite_env::type_id::create("m_axi_lite_env", this);
  m_bram_a_env = bram_a_env::type_id::create("m_bram_a_env", this);
  m_bram_b_env = bram_b_env::type_id::create("m_bram_b_env", this);
  m_virt_seqr = scrambler_ip_virtual_sequencer::type_id::create("m_virt_seqr", this);
  m_scoreboard = scrambler_ip_scoreboard::type_id::create("m_scoreboard", this);
 // m_coverage = scrambler_ip_coverage_collector::type_id::create("m_coverage", this);
  
endfunction : build_phase

// connect phase
function void scrambler_ip_env_top::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  //virtualni sekvencer   
  m_virt_seqr.m_bram_a_seq = m_bram_a_env.m_agent.m_sequencer;
  m_virt_seqr.m_axi_lite_sequencer = m_axi_lite_env.m_agent.m_sequencer;
  //scoreboard
  m_axi_lite_env.m_agent.m_monitor.m_aport.connect(m_scoreboard.m_axi_lite);
  m_bram_a_env.m_agent.m_monitor.m_aport.connect(m_scoreboard.m_bram_a);
  m_bram_b_env.m_agent.m_monitor.m_aport.connect(m_scoreboard.m_bram_b);

 
endfunction : connect_phase

`endif // SCRAMBLER_IP_ENV_TOP_SV
