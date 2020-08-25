`ifndef SCRAMBLER_IP_BASE_VIRTUAL_SV
`define SCRAMBLER_IP_BASE_VIRTUAL_SV

class scrambler_ip_base_virtual extends uvm_sequence;

	`uvm_object_utils (scrambler_ip_base_virtual)
	`uvm_declare_p_sequencer (scrambler_ip_virtual_sequencer)
	
function new (string name = "scrambler_ip_base_virtual");
	super.new(name);
endfunction
endclass
`endif 
