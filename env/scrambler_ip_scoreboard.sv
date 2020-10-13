`ifndef SCRAMBLER_IP_SCOREBOARD_SV
`define SCRAMBLER_IP_SCOREBOARD_SV

`uvm_analysis_imp_decl(_axi_lite)
`uvm_analysis_imp_decl(_bram_a)
`uvm_analysis_imp_decl(_bram_b)


class scrambler_ip_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(scrambler_ip_scoreboard)

   scrambler_ip_top_cfg m_cfg;
  //clone items
  axi_lite_item axi_clone_item;
  bram_a_item bram_a_clone;
  bram_b_item bram_b_clone;
  
  int signed bram_b_que[$];
  int unsigned bram_a_que[$];
  int num_of_data_a; //brojac za bram A
  int order_of_data_b; //brojac za bram B

  int start_count = 0; //broj konvolucija
  bit start_happend = 0, ready;
  string s;
  
	uvm_analysis_imp_axi_lite#(axi_lite_item, scrambler_ip_scoreboard) m_axi_lite;
	uvm_analysis_imp_bram_a#(bram_a_item, scrambler_ip_scoreboard) m_bram_a;
        uvm_analysis_imp_bram_b#(bram_b_item, scrambler_ip_scoreboard) m_bram_b;

	function new(string name = "scrambler_ip_scoreboard", uvm_component parent);
		super.new(name,parent);
	endfunction

	
	 extern virtual function void build_phase(uvm_phase phase);	
 	 extern virtual function void write_axi_lite(axi_lite_item m_axi_item);
 	 extern virtual function void write_bram_a(bram_a_item m_bram_a_item);
 	 extern virtual function void write_bram_b(bram_b_item m_bram_b_item);
         

endclass;


function void scrambler_ip_scoreboard::build_phase(uvm_phase phase);
	super.build_phase(phase);
	m_axi_lite = new("m_axi_lite",this);
	m_bram_a = new("m_bram_a",this);
        m_bram_b = new("m_bram_b",this);
	

   // get configuration
  if(!uvm_config_db #(scrambler_ip_top_cfg)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end

endfunction: build_phase

function void scrambler_ip_scoreboard::write_axi_lite(axi_lite_item m_axi_item);

	$cast(axi_clone_item,m_axi_item.clone());	
 
	//Ako pokusamo da pristupimo registru koji ne postoji
	  if(axi_clone_item.addr == READY_REG_ADDR || axi_clone_item.addr == COLUMNS_REG_ADDR || axi_clone_item.addr == LINES_REG_ADDR || axi_clone_item.addr == START_REG_ADDR) begin
	    `uvm_info(get_type_name(), $sformatf("AXI DATA SCOREBOARD: \n%s", axi_clone_item.sprint()), UVM_DEBUG)
	  end
	  else begin
	   `uvm_error(get_type_name(), $sformatf("Register with the address of %d doesn't exist.",axi_clone_item.addr))
	  end

	//ispisivanje item-a za debug*/
	`uvm_info(get_type_name(), $sformatf("AXI DATA SCOREBOARD: \n%s", axi_clone_item.sprint()), UVM_DEBUG)
endfunction:write_axi_lite

function void scrambler_ip_scoreboard::write_bram_a(bram_a_item m_bram_a_item);
	 $cast(bram_a_clone,m_bram_a_item.clone());
  
   	//provera validnosti podatka (da li je enable na 1)
   	if(bram_a_clone.en_a !== 1) begin 
    		`uvm_error(get_type_name(), "Bram A data is not valid because en is at 0.")
   	end
   	else begin
    		`uvm_info(get_type_name(), "Bram A data is valid.",UVM_LOW)
   	end

	//info za debug
  	`uvm_info(get_type_name(), $sformatf("BRAM A SCOREBOARD: \n%s num: %d", bram_a_clone.sprint(), num_of_data_a), UVM_DEBUG)
  	
	
endfunction: write_bram_a

function void scrambler_ip_scoreboard::write_bram_b(bram_b_item m_bram_b_item);
  $cast(bram_b_clone,m_bram_b_item.clone());

	/*provera validnosti podatka (da li je writw enable na 1)
   if(bram_b_clone.we_b !== 1) begin 
    `uvm_error(get_type_name(), "Bram B data is not valid because write enable is at 0.")
   end
   else begin
    `uvm_info(get_type_name(), "Bram B data is valid.",UVM_LOW)
   end
   */

   //debug
   `uvm_info(get_type_name(), $sformatf("BRAM B SCOREBOARD: \n%s", bram_b_clone.sprint()), UVM_DEBUG)

  /*Address checking
  if(4*order_of_data_b == bram_b_clone.m_addr_b_out) begin
    `uvm_info(get_type_name(),"Address of B is okay !", UVM_LOW)
  end
  else begin
    `uvm_error(get_type_name(),$sformatf("Address of B is %d, it should be %d", bram_b_clone.m_addr_b_out, 4*order_of_data_b))
  end
  order_of_data_b++;
*/	
endfunction: write_bram_b

`endif // scrambler_IP_SCOREBOARD_SV
