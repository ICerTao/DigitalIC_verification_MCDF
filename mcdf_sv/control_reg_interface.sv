//控制寄存器时钟复位信号接口
interface regs_cr_if;
    logic                   clk;
    logic                   rstn;
endinterface

//控制寄存器读写接口，为发起端接口（initiator）
interface regs_ini_if#(
    parameter int addr_width = 8,
    parameter int data_width);
    //时钟和复位信号与 regs_cr_if 接口连接
    logic                   clk;
    logic                   rstn;
    //读写接口与 DUT 连接
    logic [1:0]             cmd;
    logic [addr_width-1:0]  cmd_addr;
    logic [data_width-1:0]  cmd_data_r;
    logic [data_width-1:0]  cmd_data_w;

    //使用 modport 分别确定设计、激励器、监测器的信号连接方向
    modport dut (
    input cmd, cmd_addr, cmd_data_w,
    output cmd_data_r
    );
    modport stim (
    input cmd_data_r,
    output cmd, cmd_addr, cmd_data_w
    );
    modport mom (
    input cmd, cmd_addr cmd_data_w, cmd_data_r,
    );
endinterface

//控制寄存器配置和状态反馈接口，为响应端接口（responder）
interface regs_rsp_if;
    //时钟和复位信号与 regs_cr_if 接口连接
    logic                   clk;
    logic                   rstn;
    //接收端口与 DUT 连接
    logic [7:0]             slv0_avail;
    logic [7:0]             slv1_avail;
    logic [7:0]             slv2_avail;
    logic [2:0]             slv0_len;
    logic [2:0]             slv1_len;
    logic [2:0]             slv2_len;
    logic [1:0]             slv0_en;
    logic [1:0]             slv1_en;
    logic [1:0]             slv2_en;
    logic                   slv0_en;
    logic                   slv1_en;
    logic                   slv2_en;
endinterface