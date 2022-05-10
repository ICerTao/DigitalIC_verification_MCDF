//激励发生器模块
//采用 task 方法选择激励类型并产生激励
module stm_ini(
    input                   clk,
    input                   rstn,
    output [1:0]            cmd,
    output [7:0]            cmd_addr,
    output [31:0]           cmd_data_r,
    output [31:0]           cmd_data_w
);


//在任务 task 内无法对 wire 类型的接口直接赋值
//先声明几个 logic 变量以在 task 内赋值
logic [1:0]            v_cmd;
logic [7:0]            v_cmd_addr;
logic [31:0]           v_cmd_data_w;
assign cmd = v_cmd;
assign cmd_addr = v_cmd_addr;
assign cmd_data_w = v_cmd_data_w;

//定义 trans 结构体
//打包数据为一个新的总线类型
typedef struct{
    bit [1:0]   cmd;
    bit [7:0]   cmd_addr;
    bit [31:0]   cmd_data_r;
    bit [31:0]   cmd_data_w;
} trans
//定义结构体后需要进行声明和初始化
trans ts[3];
initial begin
    ts[0].cmd           = op_wr;
    ts[0].cmd_addr      = 0;
    ts[0].cmd_data_w    = 32'hFFFF_FFFF;
    ts[1].cmd           = RD;
    ts[1].cmd_addr      = 0;
    ts[2].cmd           = IDLE;
end

//写任务，即在时钟上升沿将数据写入硬件信号中
task op_wr(trans t);
    @(posedge clk);
    v_cmd <= t.cmd;
    v_cmd_addr <= t.cmd_addr;
    v_cmd_data_w <= t.cmd_data_w;
endtask
//读任务
task op_rd(trans t);
    @(posedge clk);
    v_cmd <= t.cmd;
    v_cmd_addr <= t.cmd_addr;
endtask
//空闲任务,将 cmd 置 IDLE，其余赋0
task op_idle();
    @(posedge clk);
    v_cmd <= IDLE;
    v_cmd_addr <= 0;
    v_cmd_data_w <= 0;
endtask
//声明一个方法对 ts 中的每个成员进行解析，选用所调用的方法
localparam IDLE     = 2'b00;
localparam RD       = 2'b01;
localparam WR       = 2'b10;
task op_phase(trans t);
    case(t.tmd)
        WR:     op_wr(t);
        RD:     op_rd(t);
        IDLE:   op_idle();
        default: $error("Invalid CMD");
    endcase
endtask

//产生最终激励
initial begin: stmgen
    @(posedge rstn);            //等待复位释放
    foreach (ts[i]) begin       //解析 ts 成员
        op_phase(ts[i]);        //调用 op_phase 解析方法
    end
    repeat(5)   @(posedge clk)  //保证激励发送完毕并 DUT 作出反馈
    $finish();                  //主动结束仿真
end

endmodule