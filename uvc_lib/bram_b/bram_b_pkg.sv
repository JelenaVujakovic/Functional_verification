//------------------------------------------------------------------------------
// Copyright (c) 2020 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : bram_b_pkg.sv
// Developer  : Jelena Vujakovic
// Date       : Aug 8, 2020
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef BRAM_B_PKG_SV
`define BRAM_B_PKG_SV

package bram_b_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "bram_b_common.sv"
`include "bram_b_agent_cfg.sv"
`include "bram_b_cfg.sv"
`include "bram_b_item.sv"
`include "bram_b_driver.sv"
`include "bram_b_sequencer.sv"
`include "bram_b_monitor.sv"
`include "bram_b_cov.sv"
`include "bram_b_agent.sv"
`include "bram_b_env.sv"
`include "bram_b_seq_lib.sv"

endpackage : bram_b_pkg

`include "bram_b_if.sv"

`endif // BRAM_B_PKG_SV
