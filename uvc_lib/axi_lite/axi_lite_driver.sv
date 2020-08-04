`ifndef AXI_LITE_DRIVER_SV
`define AXI_LITE_DRIVER_SV

class axi_lite_driver extends uvm_driver #(axi_lite_item);
  
  // registration macro
  `uvm_component_utils(axi_lite_driver)
  
  // virtual interface reference
  virtual interface axi_lite_if m_vif;
  
  // configuration reference
  axi_lite_agent_cfg m_cfg;
  
  // request item
  REQ m_req;
   
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // process item
  extern virtual task process_item(axi_lite_item item);
  //write transaction
  extern virtual task write_trans(axi_lite_item item);
  //read transaction
  extern virtual task read_trans(axi_lite_item item);

endclass : axi_lite_driver

// constructor
function axi_lite_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void axi_lite_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);

endfunction : build_phase

// run phase
task axi_lite_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);

  // init signals
  m_vif.s_axi_awaddr <= 'h0;
  m_vif.s_axi_awvalid <= 0;
  m_vif.s_axi_wdata <='h0;
  m_vif.s_axi_wstrb <='h0;
  m_vif.s_axi_wvalid <= 0;
  m_vif.s_axi_araddr <= 'h0;
  m_vif.s_axi_arvalid <= 0;
  m_vif.s_axi_rdata <= 'h0;
  m_vif.s_axi_rvalid <= 0;
  m_vif.s_axi_bready <= 0;
  
  forever begin
    seq_item_port.get_next_item(m_req);
    process_item(m_req);
    seq_item_port.item_done();
  end
endtask : run_phase

// process item
task axi_lite_driver::process_item(axi_lite_item item);

 @(posedge m_vif.clock iff m_vif.reset_n==1);
 fork
  begin
    fork
     write_trans(item);
    join
  end
   @(negedge m_vif.reset_n);
 join_any
 disable fork;
endtask : process_item


 task axi_lite_driver::write_trans(axi_lite_item item);
  

 endtask: write_trans


 task axi_lite_driver::read_trans(axi_lite_item item);

 endtask: read_trans
`endif // AXI_LITE_DRIVER_SV
