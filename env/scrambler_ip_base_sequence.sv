`ifndef SCRAMBLER_IP_BASE_SEQUENCE_SV
`define SCRAMBLER_IP_BASE_SEQUENCE_SV

class scrambler_ip_base_vir extends uvm_sequence;

	`uvm_object_utils (scrambler_ip_base_vir)
	`uvm_declare_p_sequencer (scrambler_ip_virtual_sequencer)
	
function new (string name = "scrambler_ip_base_vir");
	super.new(name);
endfunction
endclass

`endif 
