`ifndef AXI_LITE_COMMON_SV
`define AXI_LITE_COMMON_SV


parameter int BLOCK_SIZE = 8192;
typedef enum bit { read = 0, write = 1} rw_operation;

parameter int START_REGISTER = 4;
parameter int READY_REGISTER = 8;

`endif // AXI_LITE_COMMON_SV
