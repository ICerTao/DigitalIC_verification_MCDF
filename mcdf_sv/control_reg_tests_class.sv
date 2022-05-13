//将测试向量分为三类
//其中 basic_test 为父类

class basic_test;
    int def = 100;
    int fin;
    task test(stm_ini ini);
        $display("basic_test::test");
    endtask
    function new(int val);
        $display("basic_test::new");
        $display("basic_test::def = %0d",def);
        fin = val;
        $display("basic_test::fin = %0d",fin);
    endfunction
endclass

class test_wr extends baisc_test;
    function new();
        super.new(def); //子类通过 super 来索引父类的同名函数
        $display("test_wr::new");
    endfunction //new()
    task test(stm_ini ini);
        super.test(ini);
        $display("test_wr::test");
        ini.ts          = new[3];
        ini.ts[i]       = new();
        ini.ts[0].cmd   = WR;   //数据包的赋值
        ...
        fin             = 150;
    endtask
endclass //test_wr extends baisc_test

