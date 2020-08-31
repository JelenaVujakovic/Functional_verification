`ifndef SCRAMBLER_IP_TOP_ENV_PKG_SV
`define SCRAMBLER_IP_TOP_ENV_PKG_SV

package scrambler_ip_top_env_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

// import UVC's packages
import axi_lite_pkg::*;
import bram_a_pkg::*;
import bram_b_pkg::*;


// include env files
`include "scrambler_ip_top_cfg.sv"
`include "scrambler_ip_virtual_sequencer.sv"
`include "scrambler_ip_base_virtual.sv"
`include "scrambler_ip_virtual_sequence.sv"
`include "scrambler_ip_scoreboard.sv"
`include "scrambler_ip_env_top.sv"

endpackage : scrambler_ip_top_env_pkg
`endif 
