//将数据包和激励产生器定义为类
//定义过程中默认构造函数 new()

class trans
    bit [ 1:0] cmd; 
    bit [ 7:0] cmd_addr; 
    bit [31:0] cmd_data_w; 
    bit [31:0] cmd_data_r;
endclass

class stm_ini
    virtual interface regs_ini_if vif; 
    trans ts[]; 

    //省略声明激励方法的部分代码
    task op_wr(trans t); ...
    task op_rd(trans t); ...
    task op_idle(); ...
    task op_parse(trans t); ...
    //内部的方法必须是 task 或者 function
    task stmgen();
        wait(vif != null);
        @(posedge vif.rstn);
        foreach(ts[i]) begin
            op_parse(ts[i]);
        end 
    endtask
endclass