`ifndef SCRAMBLER_IP_COVERAGE_COLLECTOR_SV
`define SCRAMBLER_IP_COVERAGE_COLLECTOR_SV

`uvm_analysis_imp_decl(_axi_lite_cov)
`uvm_analysis_imp_decl(_bram_a_cov)
`uvm_analysis_imp_decl(_bram_b_cov)


class scrambler_ip_coverage_collector extends uvm_scoreboard;

  
  
	uvm_analysis_imp_axi_lite_cov#(axi_lite_item, scrambler_ip_coverage_collector) m_axi_lite_cov;
	uvm_analysis_imp_bram_a_cov#(bram_a_item, scrambler_ip_coverage_collector) m_bram_a_cov;
    uvm_analysis_imp_bram_b_cov#(bram_b_item, scrambler_ip_coverage_collector) m_bram_b_cov;
 
	

	extern function new(string name = "scrambler_ip_coverage_collector", uvm_component parent);
	 extern virtual function void build_phase(uvm_phase phase);	
 	/* extern virtual function void write_axi_lite_cov(axi_lite_item m_axi_item);
 	 extern virtual function void write_bram_a_cov(bram_a_item m_bram_a_item);
 	 extern virtual function void write_bram_b_cov(bram_b_item m_bram_b_item);
 	
*/

endclass

// constructor
function scrambler_ip_coverage_collector::new(string name = "scrambler_ip_coverage_collector", uvm_component parent);

  super.new(name,parent);
  

endfunction : new

function void scrambler_ip_coverage_collector::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	
endfunction: build_phase





`endif // scrambler_IP_COVERAGE_COLLECTOR_SV
