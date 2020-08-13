`ifndef SCRAMBLER_IP_VIRTUAL_SEQUENCER_SV
`define SCRAMBLER_IP_VIRTUAL_SEQUENCER_SV

class scrambler_ip_virtual_sequencer extends uvm_sequencer;

	`uvm_component_utils (scrambler_ip_virtual_sequencer)
	
	
	function new(string name = "scrambler_ip_virtual_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	axi_lite_sequencer m_axi_lite_sequencer;
	bram_a_sequencer m_bram_a_seq;
	
endclass : scrambler_ip_virtual_sequencer

`endif 
