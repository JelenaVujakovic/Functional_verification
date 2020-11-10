`ifndef AXI_LITE_COVERAGE_SV
`define AXI_LITE_COVERAGE_SV

class axi_lite_coverage extends uvm_subscriber#(axi_lite_item);
  
  // registration macro
  `uvm_component_utils(axi_lite_coverage)
  
  // configuration reference
  axi_lite_agent_cfg m_cfg;
  
  // coverage fields 
  //clone items
  axi_lite_item axi_lite_clone;
  
  // coverage groups
  covergroup axi_lite_cg;
    option.per_instance = 1;
    option.comment = "AXI-LITE coverage group";
    
    //Cover register address access
    axi_lite_register_address : coverpoint axi_lite_clone.addr{
        bins START_REGISTER = {'h4};
        bins READY_REGISTER = {'h8};
    }
   
    //Cover operation type (READ)
    axi_lite_read : coverpoint axi_lite_clone.rw_op == read {
        bins read = {0};
    }
    //Cover operation type (WRITE)
    axi_lite_write : coverpoint axi_lite_clone.rw_op != read {
        bins write = {1};
    }
    //Cover data
    axi_lite_data: coverpoint axi_lite_clone.data{
        bins low = {0};
        bins high = {1};
    }

    //Cover ready register value
    cross_axi_lite_data_value_and_reg_addr: cross axi_lite_register_address,axi_lite_data{
        bins ready_register_read = binsof(addr) intersect {'h8} && binsof(data);
        bins start_register_read = binsof(addr) intersect {'h4} && binsof(data);
    }
    
    //Cover read/write operation on register address
    cross_axi_lite_read_operation_and_reg_addr: cross axi_lite_register_address,axi_lite_read,axi_lite_write{
        bins start_register_read = binsof(addr) intersect{START_REGISTER} && binsof(axi_lite_read) intersect {0};
        bins start_register_write = binsof(addr) intersect{START_REGISTER} && binsof(axi_lite_write) intersect {1};
        bins ready_register_read = binsof(addr) intersect{READY_REGISTER} && binsof(axi_lite_read) intersect {0};
        ignore_bins read_only_register_ready = binsof(addr) intersect{READY_REGISTER} && binsof(axi_lite_write) intersect {1};
    }
       
  endgroup : axi_lite_cg
  
  // constructor
  extern function new(string name, uvm_component parent);
  // analysis implementation port function
  extern virtual function void write(axi_lite_item t);

endclass : axi_lite_coverage

// constructor
function axi_lite_coverage::new(string name, uvm_component parent);
  super.new(name, parent);
  axi_lite_cg = new();
endfunction : new

// analysis implementation port function
function void axi_lite_coverage::write(axi_lite_item t);
  $cast(axi_lite_clone,t.clone());
  axi_lite_cg.sample();
endfunction : write

`endif 
