/****************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            bram_a_agent.sv

    DESCRIPTION     master agent

 ****************************************************************************/

`ifndef bram_a_agent_SV
`define bram_a_agent_SV
    
/**
 * Class: bram_a_agent
 */
class bram_a_agent extends uvm_agent;
    
    // configuration object
    bram_a_cfg       m_cfg;

    // components
    bram_a_driver       m_driver;
    bram_a_sequencer    m_sequencer;
    bram_a_monitor      m_monitor;

    // UVM factory registration
    `uvm_component_utils_begin(bram_a_agent)
        `uvm_field_object(m_cfg, UVM_DEFAULT | UVM_REFERENCE)
    `uvm_component_utils_end    

    // new - constructor
	function new(string name = "bram_a_agent", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
    
    // UVM build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // get configuration object from db
        if(!uvm_config_db#(bram_a_cfg)::get(this, "", "bram_a_cfg", m_cfg))
            `uvm_fatal("NOCONFIG",{"Config object must be set for: ",get_full_name(),".m_cfg"})

        // create driver and sequencer if agent is active
        //if(m_cfg.m_is_active == UVM_ACTIVE) begin
            m_sequencer = bram_a_sequencer::type_id::create("m_sequencer", this);
            m_driver = bram_a_driver::type_id::create("m_driver", this);
        //end
        // always create m_monitoritor
        m_monitor = bram_a_monitor::type_id::create("m_monitor", this);
    endfunction : build_phase

    // UVM connect_phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // connect driver and sequencer if agent is active
        //if(m_cfg.m_is_active == UVM_ACTIVE) begin
            m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
        //end
    endfunction : connect_phase
    
endclass : bram_a_agent

`endif

