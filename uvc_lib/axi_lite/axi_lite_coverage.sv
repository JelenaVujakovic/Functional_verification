`ifndef AXI_LITE_COVERAGE_SV
`define AXI_LITE_COVERAGE_SV

class axi_lite_coverage extends uvm_subscriber #(axi_lite_item);
  
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
    
    //Cover register address access
    axi_lite_register_address : coverpoint axi_lite_clone.addr{
        bins START_REGISTER = {'h4};
        bins READY_REGISTER = {'h8};
    }
   
    //Cover both operation type (READ/WRITE)
    axi_lite_read_write : coverpoint axi_lite_clone.rw_op {
        bins read = {0};
        bins write = {1};
    }
    //Cover data
    axi_lite_data: coverpoint axi_lite_clone.data{
        bins low = {0};
        bins high = {1};
    }
    //Cover rw operation on START REGISTER address
    cross_axi_lite_rw_op_and_start_reg_addr: cross axi_lite_register_address,axi_lite_read_write{
        bins start_register_read = binsof(addr) intersect {'h4} && binsof(rw) intersect {0};
        bins start_register_write = binsof(addr) intersect {'h4} && binsof(rw) intersect {1};
    }
    //Cover read operation on READY REGISTER address,READY REGISTER read-only
    cross_axi_lite_read_op_and_ready_reg_addr: cross axi_lite_register_address,axi_lite_read_write{
        bins ready_register_read = binsof(addr) intersect {'h8} && binsof(rw) intersect {0};
    }
    //Cover ready register value
    cross_axi_lite_data_value_and_ready_reg_addr: cross axi_lite_register_address,axi_lite_data{
        bins ready_register_read = binsof(addr.READY_REGISTER) && binsof(data);
    }
    //Cover start register value
    cross_axi_lite_data_value_and_start_reg_addr: cross axi_lite_register_address,axi_lite_data{
        bins start_register_read = binsof(addr.START_REGISTER) && binsof(data);
    }
    //Cover READY_REGISTER = '1' -> START_REGISTER = '0'
    cross_check_register_value: cross axi_lite_register_address,axi_lite_data{
        bins ready_register_value = binsof(addr.READY_REGISTER) && binsof(data) intersect {1};        
        bins start_register_value = binsof(addr.START_REGISTER) && binsof(data) intersect {0};
        
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
  //m_signal_value_cov = item.m_signal_value;
  axi_lite_cg.sample();
endfunction : write

`endif 
