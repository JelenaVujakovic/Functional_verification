`ifndef SCRAMBLER_IP_VIRTUAL_SEQUENCE_SV
`define SCRAMBLER_IP_VIRTUAL_SEQUENCE_SV

class scrambler_ip_virtual_sequence extends scrambler_ip_base_virtual;
  
	`uvm_object_utils (scrambler_ip_virtual_sequence)

  rand bit [31:0] data;
 
	
function new (string name = "scrambler_ip_virtual_sequence");
	super.new(name);
endfunction

	bram_a_basic_seq m_a_seq;
	axi_lite_write_start_register_value_seq m_axi_lite_write_start_register_value_seq;
    axi_lite_read_ready_register_seq m_axi_lite_read_ready_register_seq;
	
task pre_body();
	super.pre_body();
	
	m_a_seq = bram_a_basic_seq::type_id::create ("m_a_seq");
	m_axi_lite_write_start_register_value_seq = axi_lite_write_start_register_value_seq::type_id::create ("m_axi_lite_write_start_register_value_seq");
    m_axi_lite_read_ready_register_seq = axi_lite_read_ready_register_seq::type_id::create ("m_axi_lite_read_ready_register_seq");
	
endtask: pre_body

task body();
	
  //Read value from READY register
  if(!m_axi_lite_read_ready_register_seq.randomize()) begin 
	   `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
        `uvm_info(get_type_name(), "AXI read ready register sequence", UVM_LOW)
        m_axi_lite_read_ready_register_seq.start(p_sequencer.m_axi_lite_sequencer);
  
  //Set value of START register
  if(!m_axi_lite_write_start_register_value_seq.randomize() with { data =='h1;} ) begin 
	   `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
       `uvm_info(get_type_name(), " AXI write '1' to start register sequence ", UVM_LOW)
	  m_axi_lite_write_start_register_value_seq.start(p_sequencer.m_axi_lite_sequencer);
  fork 
   begin 
        #1us;
        //Reset START REGISTER value to '0'
        if(!m_axi_lite_write_start_register_value_seq.randomize() with { data =='h0;}) begin 
	       `uvm_fatal(get_type_name(), "Failed to randomize.")
        end
          `uvm_info(get_type_name(), " --- AXI write '0' to start register sequence--- ", UVM_LOW)
	      m_axi_lite_write_start_register_value_seq.start(p_sequencer.m_axi_lite_sequencer);
        #50us;
   end
   begin 
        for(int i = 0; i < BLOCK_SIZE; i++) begin
                 if(!m_a_seq.randomize() with {m_input_data == data;}) begin
		            `uvm_fatal(get_type_name(), "Failed to randomize.")
		         end
                     `uvm_info(get_type_name(), "BRAM A sequence ", UVM_LOW)
			         m_a_seq.start(p_sequencer.m_bram_a_seq);
        end
   end
 join

endtask: body
endclass

`endif 
