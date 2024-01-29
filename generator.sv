class generator;

int total = 1024;
mailbox gen2drv_mbx;
event drv_done2gen_evt;
event col2gen_evt;
mailbox gen2col_mbx;

virtual clk_interface clk_intf;

task run;
begin
    transaction trx = new();
    transaction trx_col = new();
    for(int i = 0; i < total; i++) begin
        assert(trx.randomize());
        $display ("T=%0t [Generator] Loop:%0d/%0d create next item", $time, i+1, total);
        gen2drv_mbx.put(trx);
        // trx_col = trx.copy();
        // gen2col_mbx.put(trx_col);
        $display ("T=%0t [Generator] Wait for driver to be done", $time);
        @(drv_done2gen_evt);
        // @(col2gen_evt);
    end
    @(posedge clk_intf.clk);
    #10;
end
endtask

endclass