`ifndef AXI_LITE_IF_SV
`define AXI_LITE_IF_SV

interface axi_lite_if(input clock, input reset_n);
  
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  
  // signals

 
  logic [3:0] s_axi_awaddr;
  logic s_axi_awvalid;
  logic s_axi_awready; 
  logic [31:0] s_axi_wdata;
  logic [3:0] s_axi_wstrb;
  logic s_axi_wvalid; 
  logic s_axi_wready; 
  logic [1:0] s_axi_bresp; 
  logic s_axi_bvalid; 
  logic s_axi_bready;
  logic [3:0] s_axi_araddr;
  logic s_axi_arvalid;
  logic s_axi_arready;
  logic [31:0] s_axi_rdata; 
  logic [1:0] s_axi_rresp; 
  logic s_axi_rvalid; 
  logic s_axi_rready;
  logic [2:0] s_axi_awprot;
  
  
endinterface : axi_lite_if

`endif // AXI_LITE_IF_SV
