class driver;
    event drv_done2gen_evt;
    event gen2drv_done_evt;
    event drv2mon_last_evt;
    mailbox gen2drv_mbx;
    virtual counter_interface.drv ctr_intf;
    virtual clk_interface clk_intf;

    task run;
    begin
        fork
            // @(gen2drv_done_evt);
            send2dut();
        join_any
        // ->drv2mon_last_evt;
    end
    endtask

    task send2dut;
    begin
        transaction trx, tmp;
        $display ("T=%0t [Driver] starting ...", $time);
        forever begin
            $display ("T=%0t [Driver] waiting for item ...", $time);
            gen2drv_mbx.get(tmp);
            trx = tmp.copy();
            @(posedge clk_intf.pre_clk);
            trx.print("Driver");
            ctr_intf.rst_n <= trx.rst_n;
            ctr_intf.enable <= trx.enable;
            ctr_intf.load <= trx.load;
            ctr_intf.up_down_n <= trx.up_down_n;
            ctr_intf.data_input <= trx.data_input;
            ->drv_done2gen_evt;
        end
    end
    endtask

endclass
