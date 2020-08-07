/****************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            bram_b_monitor.sv

    DESCRIPTION     

 ****************************************************************************/

`ifndef bram_b_monitor_SV
`define bram_b_monitor_SV

/**
 * Class: bram_b_monitor
 */
class bram_b_monitor extends uvm_monitor;
    
    // apb virtual interface
    virtual bram_b_if m_vif;
    
    // configuration
    bram_b_agent_cfg m_cfg;
    
    // TLM - from monitor to other components
   // uvm_analysis_port #(bram_b_item) item_collected_port;
    
    // keep track of number of transactions
    int unsigned num_transactions = 0;
    
    // current transaction
    bram_b_item m_item;
    
    // UVM factory registration
    `uvm_component_utils_begin(bram_b_monitor)
        `uvm_field_object(m_cfg, UVM_DEFAULT | UVM_REFERENCE)
    `uvm_component_utils_end
    
 

    // new - constructor
	function new(string name = "bram_b_monitor", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
    
    // UVM build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // get configuration object from db
        if(!uvm_config_db#(bram_b_agent_cfg)::get(this, "", "bram_b_agent_cfg", m_cfg))
            `uvm_fatal("NOCONFIG",{"Config object must be set for: ",get_full_name(),".m_cfg"})
    endfunction: build_phase
    
    // UVM connect_phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // get interface from db
        if(!uvm_config_db#(virtual bram_b_if)::get(this, "", "bram_b_if", m_vif))
            `uvm_fatal("NOm_vif",{"virtual interface must be set for: ",get_full_name(),".m_vif"})    
    endfunction : connect_phase
    
    // additional class methods
    extern virtual task run_phase(uvm_phase phase);
    extern virtual task collect_transactions();
    extern virtual function void report_phase(uvm_phase phase);

endclass : bram_b_monitor

// UVM run_phase
task bram_b_monitor::run_phase(uvm_phase phase);
    forever begin
        @(posedge m_vif.reset_n); // reset dropped
        `uvm_info(get_type_name(), "Reset dropped", UVM_MEDIUM)
    
        fork
            collect_transactions(); // thread killed at reset
            @(negedge m_vif.reset_n); // reset is active low
        join_any
        disable fork;
    end
endtask : run_phase

// monitor apb interface and collect transactions
task bram_b_monitor::collect_transactions();
    forever begin
    
    end // forever
endtask : collect_transactions

// UVM report_phase
function void bram_b_monitor::report_phase(uvm_phase phase);
    // final report
    `uvm_info(get_type_name(), $sformatf("Report: APB monitor collected %0d transfers", num_transactions), UVM_LOW);
endfunction : report_phase


`endif

