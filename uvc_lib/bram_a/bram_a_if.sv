`ifndef BRAM_A_IF_SV
`define BRAM_A_IF_SV

interface bram_a_if(input clock, input reset_n);
  
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  
  // signals
  logic [31:0] input_data;
  logic [31:0] addra;
  logic ena;
  logic wea;
  //dodato zbog greske koju izbacuje simulator kad se na dia port ne dovede nista ili .(open)
  logic [31:0] dina;
    
  
  
endinterface : bram_a_if

`endif // BRAM_A_IF_SV
