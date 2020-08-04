//Scoreboard za Convolusion IP : Svo cekiranje se vrsi u write funkcijama, nema run phase

`ifndef SCRAMBLER_IP_SCOREBOARD_SV
`define SCRAMBLER_IP_SCOREBOARD_SV

`uvm_analysis_imp_decl(_axi_lite)
`uvm_analysis_imp_decl(_bram_a)
`uvm_analysis_imp_decl(_bram_b)
`uvm_analysis_imp_decl(_bram_c)

class scrambler_ip_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scrambler_ip_scoreboard)

`endif // SCRAMBLER_IP_SCOREBOARD_SV
