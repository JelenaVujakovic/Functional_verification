`ifndef SCRAMBLER_IP_TEST_PKG_SV
`define SCRAMBLER_IP_TEST_PKG_SV

package scrambler_ip_test_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

// import UVC's packages
import bram_a_pkg::*;
import bram_b_pkg::*;
import axi_lite_pkg::*;

// import env package
import scrambler_ip_top_env_pkg::*;

// include tests
`include "test_scrambler_ip_base.sv"
`include "test_scrambler_ip_example.sv"

endpackage : scrambler_ip_test_pkg

`endif 
