class monitor;
    virtual counter_interface.mon ctr_intf;
    virtual clk_interface clk_intf;

    event drv2mon_last_evt;
    mailbox mon2sco_mbx;

    task run();
    begin
        fork
            dut2mon();
            // @(drv2mon_last_evt);
        join_any
    end
    endtask

    task dut2mon();
    transaction trx;
    begin
        $display("T=%0t [Monitor] starting...", $time);
        trx = new;
        forever begin
            @(posedge clk_intf.clk);
            #1;
            trx.rst_n = ctr_intf.rst_n;
            trx.enable = ctr_intf.enable;
            trx.load = ctr_intf.load;
            trx.up_down_n = ctr_intf.up_down_n;
            trx.data_input = ctr_intf.data_input;
            trx.data_output = ctr_intf.data_output;
            trx.print("Monitor");
            mon2sco_mbx.put(trx);
        end
    end
    endtask
endclass
