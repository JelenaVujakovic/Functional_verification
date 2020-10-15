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


  bit [14:0] bram_a_address;
  bit [14:0] bram_b_address;
  bit [14:0] bram_b_address_calc;


  bit start_flag=0;
  bit ready_flag;
  int n;
  int number_of_transactions;
  
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
  //extern virtual function void report_phase(uvm_phase phase);
  extern virtual function void scrambler_address_checking(ref int unsigned bram_a_que[$],ref int signed bram_b_que[$]);

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
  
    //AXI LITE Register address check
    if(axi_clone_item.addr == READY_REGISTER || axi_clone_item.addr == START_REGISTER) begin
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
   //Fill bram_a_que with bram a addresses for checking
   bram_a_que.push_back(bram_a_clone.m_address); 
   

   //Check if m_ena signal is set to 1
   asrt_m_ena : assert (bram_a_clone.m_ena == 1)
        `uvm_info(get_type_name(), "Check succesfull: m_ena asserted", UVM_HIGH)
   else
	    `uvm_error(get_type_name(), $sformatf("Observed m_ena signal mismatch: m_ena = %0d", bram_a_clone.m_ena))

  //info za debug
  `uvm_info(get_type_name(), $sformatf("BRAM A SCOREBOARD: \n%s", bram_a_clone.sprint()), UVM_DEBUG)

	
endfunction: write_bram_a

function void scrambler_ip_scoreboard::write_bram_b(bram_b_item m_bram_b_item);
   
	
    $cast(bram_b_clone,m_bram_b_item.clone());
   
    //Fill bram_b_que with bram b addresses for checking
    bram_b_que.push_back(bram_b_clone.m_addr_b_out);

    //Check if m_wr_en signal is set to 1
    asrt_m_wr_en : assert (bram_b_clone.m_wr_en == 1)
	    `uvm_info(get_type_name(), "Check succesfull: m_wr_en asserted", UVM_HIGH)
	else
	    `uvm_error(get_type_name(), $sformatf("Observed m_wr_en signal mismatch: m_wr_en = %0d", bram_b_clone.m_wr_en))
    
    
        scrambler_address_checking(bram_a_que,bram_b_que);
   
   // else begin
       
        
    
endfunction: write_bram_b

function void scrambler_ip_scoreboard::scrambler_address_checking(ref int unsigned bram_a_que[$],ref int signed bram_b_que[$]);
  
    if(bram_b_que.size() == BLOCK_SIZE && bram_a_que.size()==BLOCK_SIZE) begin
    start_flag=1;
    // Check if address sent to bram a and address received in bram b match
    for(int i = 0; i < BLOCK_SIZE; i++) begin
	    bram_a_address = bram_a_que.pop_front();
		bram_b_address = bram_b_que.pop_front();
        `uvm_info(get_type_name(), $sformatf("Bram A address is: %d", bram_a_address), UVM_DEBUG)
        `uvm_info(get_type_name(), $sformatf("Bram A address is: %d", bram_a_address), UVM_DEBUG)
		//Calculate value of bram b address according to specification
		bram_b_address_calc = (8192 - n + (bram_a_address/4)) * 4;
		if ((bram_a_address/4) % 4 == 0)
		    n = n + 8;
		//Compare values of calculated and received address of bram b
	    asrt_addr_a_eq_addr_b : assert (bram_b_address == bram_b_address_calc)
	        `uvm_info(get_type_name(), "Check succesfull: bram_b_address == bram_b_address_calc", UVM_HIGH)
		else
			`uvm_error(get_type_name(), $sformatf("Observed bram_b_address and bram_b_address_calc mismatch: bram_b_address = %0d, bram_b_address_calc = %0d", bram_b_address, bram_b_address_calc))
	    //Count transactions
		number_of_transactions ++ ;
     end
   end
   else begin
        start_flag=0;
        `uvm_info(get_type_name(), "BRAM que size less than BLOCK SIZE.\n",UVM_HIGH)
        `uvm_info(get_type_name(), $sformatf("Bram A que block size is is: %d", bram_b_que.size()), UVM_DEBUG)
        `uvm_info(get_type_name(), $sformatf("Bram A que block size is is: %d", bram_b_que.size()), UVM_DEBUG)
   end
endfunction: scrambler_address_checking
`endif 
