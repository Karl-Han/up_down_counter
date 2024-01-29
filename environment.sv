class environment;
    generator gen;
    collector col;
    driver drv;
    monitor mon;
    scoreboard sco;

    virtual counter_interface ctr_intf;
    virtual clk_interface clk_intf;

    mailbox gen2col_mbx;
    mailbox gen2drv_mbx;
    event drv_done2gen_evt;
    event col2gen_evt;
    mailbox mon2sco_mbx;

    function new();
        gen = new;
        col = new();
        drv = new;
        mon = new;
        sco = new;

        gen2drv_mbx = new();
        mon2sco_mbx = new();
    endfunction

    task run;
    begin
        drv.ctr_intf = ctr_intf;
        mon.ctr_intf = ctr_intf;
        gen.clk_intf = clk_intf;
        drv.clk_intf = clk_intf;
        mon.clk_intf = clk_intf;

        gen.gen2drv_mbx = gen2drv_mbx;
        drv.gen2drv_mbx = gen2drv_mbx;
        gen.gen2col_mbx = gen2col_mbx;
        col.gen2col_mbx = gen2col_mbx;
        mon.mon2sco_mbx = mon2sco_mbx;
        sco.mon2sco_mbx = mon2sco_mbx;
        gen.drv_done2gen_evt = drv_done2gen_evt;
        drv.drv_done2gen_evt = drv_done2gen_evt;
        gen.col2gen_evt = col2gen_evt;
        col.col2gen_evt = col2gen_evt;

        fork
            gen.run();
            // col.run();
            drv.run();
            mon.run();
            sco.run();
        join_any
    end
    endtask
endclass