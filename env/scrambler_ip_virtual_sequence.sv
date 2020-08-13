`ifndef SCRAMBLER_IP_VIRTUAL_SEQUENCE_SV
`define SCRAMBLER_IP_VIRTUAL_SEQUENCE_SV

class scrambler_ip_virtual_sequence extends scrambler_ip_base_virtual;
  
	`uvm_object_utils (scrambler_ip_virtual_sequence)

  rand bit [31:0] data;
 
	
function new (string name = "scrambler_ip_virtual_sequence");
	super.new(name);
endfunction

	bram_a_basic_seq m_a_seq;
	axi_lite_write_seq m_axi_lite_seq;
	
task pre_body();
	super.pre_body();
	
	m_a_seq = bram_a_basic_seq::type_id::create ("m_a_seq");
	m_axi_lite_seq = axi_lite_write_seq::type_id::create ("m_axi_lite_seq");

	
endtask: pre_body

task body();
	

  /*if(!m_axi_lite_read_seq.randomize() with {addr == READY_REG_ADDR;}) begin //citanje ready registra
	   `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
        //m_axi_lite_read_seq.start(p_sequencer.m_axi_lite_sequencer);

  if(!m_axi_lite_seq.randomize() with {addr == START_REG_ADDR; data == 'h1;}) begin //start
	   `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
	  m_axi_lite_seq.start(p_sequencer.m_axi_lite_sequencer);
  
  fork 
   begin
    
    #1us;
    if(!m_axi_lite_seq.randomize() with {addr == START_REG_ADDR; data =='h0;}) begin //obrisi start registar
	   `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
	  m_axi_lite_seq.start(p_sequencer.m_axi_lite_sequencer);
    #50us;
   end
   begin
      if(!m_a_seq.randomize() with { m_data_a== data;})
         begin
				 `uvm_fatal(get_type_name(), "Failed to randomize.")
	     end
       `uvm_info(get_type_name(), $sformatf("Size is %d, queue is : %p.",data),UVM_LOW)
		    m_a_seq.start(p_sequencer.m_bram_a_seq);
   end
   /*begin 
       repeat( 8192) begin
				  if(!m_b_seq.randomize() with {m_type_of_kernel == kernel_type;}) begin
				    `uvm_fatal(get_type_name(), "Failed to randomize.")
				  end
				  m_b_seq.start(p_sequencer.m_bram_b_seq);
     end*/
   //end
 //join

endtask: body
endclass

`endif 
