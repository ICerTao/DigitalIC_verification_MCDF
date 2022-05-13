//使用虚接口在激励发生器内做采用或驱动，
//方法的声明同 ‘control_reg_stimulator.sv’ 

module stm_ini;
virtual interface regs_ini_if vif;

trans ts[];             //声明动态数组，将大小的调整交给更高层的 tb.arrini

//激励产生模块
initial begin: stemgen
    wait(vif != null);
    @(posedge vif.rstn);
    foreach(ts[i]) begin
        op_parse(ts[i]);
    end
    repeat(5) @(posedge vif.clk);
    $finish;
end
    
endmodule

//在 tb 中进行例化接口传递
module tb;
stm_ini ini();

initial begin: setif
    ini.vif = iniif;
end
endmodule