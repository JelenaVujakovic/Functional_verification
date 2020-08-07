`ifndef SCRAMBLER_IP_VIR_SEQUENCE_SV
`define SCRAMBLER_IP_VIR_SEQUENCE_SV

class scrambler_ip_vir_sequence extends scrambler_ip_base_vir;
  
	`uvm_object_utils (scrambler_ip_vir_sequence)

  rand int unsigned data_que_a [$];

 
	
function new (string name = "scrambler_ip_vir_sequence");
	super.new(name);
endfunction


	
task pre_body();
	super.pre_body();

	
endtask: pre_body

task body();
	
	
  
endtask: body
endclass

`endif 
