/****************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            axi_lite_agent.sv

    DESCRIPTION     master agent

 ****************************************************************************/

`ifndef axi_lite_agent_SV
`define axi_lite_agent_SV
    
/**
 * Class: axi_lite_agent
 */
class axi_lite_agent extends uvm_agent;
    
    // configuration object
    axi_lite_cfg       m_cfg;

    // components
    axi_lite_driver       m_driver;
    axi_lite_sequencer    m_sequencer;
    axi_lite_monitor      m_monitor;

    // UVM factory registration
    `uvm_component_utils_begin(axi_lite_agent)
        `uvm_field_object(m_cfg, UVM_DEFAULT | UVM_REFERENCE)
    `uvm_component_utils_end    

    // new - constructor
	function new(string name = "axi_lite_agent", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
    
    // UVM build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // get configuration object from db
        if(!uvm_config_db#(axi_lite_cfg)::get(this, "", "axi_lite_cfg", m_cfg))
            `uvm_fatal("NOCONFIG",{"Config object must be set for: ",get_full_name(),".m_cfg"})

        // create driver and sequencer if agent is active
        //if(m_cfg.m_is_active == UVM_ACTIVE) begin
            m_sequencer = axi_lite_sequencer::type_id::create("m_sequencer", this);
            m_driver = axi_lite_driver::type_id::create("m_driver", this);
        //end
        // always create m_monitoritor
        m_monitor = axi_lite_monitor::type_id::create("m_monitor", this);
    endfunction : build_phase

    // UVM connect_phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // connect driver and sequencer if agent is active
        //if(m_cfg.m_is_active == UVM_ACTIVE) begin
            m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
        //end
    endfunction : connect_phase
    
endclass : axi_lite_agent

`endif

