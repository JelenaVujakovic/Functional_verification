`ifndef BRAM_A_IF_SV
`define BRAM_A_IF_SV

interface bram_a_if(input clock, input reset_n);
  
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  
  // signals
  logic [31:0] dia;
  logic [31:0] addra;
  logic ena;
  logic wea;
  
endinterface : bram_a_if

`endif // BRAM_A_IF_SV
