//将测试向量的生成从激励产生器中剥离出来
module tests;
task test_wr;
    tb.ini.ts = new[2];
    //...
endtask
task test_rd;
    //...
endtask
endmodule

//在 tb 中进行例化和连接
//tests tts();
//if(t == "test_wr")   tts.test_wr();