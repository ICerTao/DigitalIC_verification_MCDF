//该模块为寄存器配置模块，可以通过修改寄存器的值来控制 slave 模块的功能，且能读出寄存器的值
module control_registers(
    //接口定义时添加后缀 _i,_o 来区分信号流向

    //系统信号
    input                           clk_i,
    input                           rstn_i.
    //控制寄存器读写信号
    input       [1:0]               cmd_i,
    input       [7:0]               cmd_addr_i,
    input       [31:0]              cmd_data_i.
    output      [31:0]              cmd_data_o,
    //slave 模块控制信号与握手信号
    input       [7:0]               slv0_avail_i,
    input       [7:0]               slv1_avail_i,
    input       [7:0]               slv2_avail_i,
    output      [2:0]               slv0_len_o,
    output      [2:0]               slv1_len_o,
    output      [2:0]               slv2_len_o,
    output                          slv0_en_o,
    output                          slv1_en_o,
    output                          slv2_en_o,
);
    
endmodule