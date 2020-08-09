`ifndef BRAM_B_IF_SV
`define BRAM_B_IF_SV

interface bram_b_if(input clock, input reset_n);
  
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  logic signal;
  // signals
  logic [31:0] data_b_out;
  logic [31:0] addrb;
  logic enb;
  logic web;
  
endinterface : bram_b_if

`endif // BRAM_B_IF_SV
