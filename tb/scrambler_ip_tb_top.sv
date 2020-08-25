`ifndef SCRAMBLER_IP_TB_TOP_SV
`define SCRAMBLER_IP_TB_TOP_SV

// define timescale
`timescale 1ns/1ns

module scrambler_ip_tb_top;
  
  `include "uvm_macros.svh"  
  import uvm_pkg::*;
  
  // import test package
  import scrambler_ip_test_pkg::*;
    
  // signals
  reg reset_n;
  reg clock;
  
  
  // UVC interface instance
  axi_lite_if axi_lite_if_inst(clock, reset_n);
  bram_a_if   bram_a_if_inst(clock, reset_n);
  bram_b_if   bram_b_if_inst(clock, reset_n);
   	
  	
  // DUT instance
  scrambler_axi_ip_v1_0 dut(
    .s00_axi_aresetn (reset_n),
    .s00_axi_aclk    (clock),
    .s00_axi_awaddr  (axi_lite_if_inst.s_axi_awaddr),
    .s00_axi_awprot  (axi_lite_if_inst.s_axi_awprot),
    .s00_axi_awvalid (axi_lite_if_inst.s_axi_awvalid),
    .s00_axi_awready (axi_lite_if_inst.s_axi_awready),
    .s00_axi_wdata   (axi_lite_if_inst.s_axi_wdata),
    .s00_axi_wstrb   (axi_lite_if_inst.s_axi_wstrb),
    .s00_axi_wvalid  (axi_lite_if_inst.s_axi_wvalid),
    .s00_axi_wready  (axi_lite_if_inst.s_axi_wready),
    .s00_axi_bresp   (axi_lite_if_inst.s_axi_bresp),
    .s00_axi_bvalid  (axi_lite_if_inst.s_axi_bvalid),
    .s00_axi_bready  (axi_lite_if_inst.s_axi_bready),
    .s00_axi_araddr  (axi_lite_if_inst.s_axi_araddr),
    .s00_axi_arvalid (axi_lite_if_inst.s_axi_arvalid),
    .s00_axi_arready (axi_lite_if_inst.s_axi_arready),
    .s00_axi_rdata   (axi_lite_if_inst.s_axi_rdata),
    .s00_axi_rresp   (axi_lite_if_inst.s_axi_rresp),
    .s00_axi_rvalid  (axi_lite_if_inst.s_axi_rvalid),
    .s00_axi_rready  (axi_lite_if_inst.s_axi_rready),
    .clka            (open),
    .clkb            (open),
    .reseta          (open),
    .resetb          (open),
    .ena             (bram_a_if_inst.ena),
    .enb             (bram_b_if_inst.enb),
    .addra           (bram_a_if_inst.addra),
    .addrb           (bram_b_if_inst.addrb),
    .dina            (bram_a_if_inst.dina),
    .douta           (bram_a_if_inst.input_data),
    .dinb            (bram_b_if_inst.data_b_out),
    .doutb           (0),
    .wea             (bram_a_if_inst.wea),
    .web             (bram_b_if_inst.web)
    );
  

  // configure UVC's virtual interface in DB
  initial begin : config_if_block
    uvm_config_db#(virtual axi_lite_if)::set(uvm_root::get(), "uvm_test_top.m_scrambler_ip_env_top.m_axi_lite_env.m_agent", "m_vif", axi_lite_if_inst);
    uvm_config_db#(virtual bram_a_if)::set(uvm_root::get(), "uvm_test_top.m_scrambler_ip_env_top.m_bram_a_env.m_agent", "m_vif", bram_a_if_inst);
    uvm_config_db#(virtual bram_b_if)::set(uvm_root::get(), "uvm_test_top.m_scrambler_ip_env_top.m_bram_b_env.m_agent", "m_vif", bram_b_if_inst);
  end
    
  // define initial clock value and generate reset
  initial begin : clock_and_rst_init_block
    reset_n <= 1'b0;
    clock <= 1'b1;
    #50 reset_n <= 1'b1;
  end
  
  // generate clock
  always begin : clock_gen_block
    #5 clock <= ~clock;
  end
 
  // run test
  initial begin : run_test_block
    run_test();
  end
  
endmodule : scrambler_ip_tb_top

`endif // SCRAMBLER_IP_TB_TOP_SV
