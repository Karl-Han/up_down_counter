class TransactionCovergroup;
    logic rst_n;
    logic enable;
    logic load;
    logic up_down_n;
    covergroup CovGrp;
        coverpoint rst_n;
        coverpoint enable iff (!rst_n);
        coverpoint load iff (!rst_n && enable == 1'b1);
        coverpoint up_down_n iff (!rst_n && enable == 1'b1 && load == 1'b0);
        cross rst_n, enable, load, up_down_n;
    endgroup

    function new();
    begin
        CovGrp = new;
    end
    endfunction
endclass

class collector;
    TransactionCovergroup covgrp;
    mailbox gen2col_mbx;
    event col2gen_evt;

    function new();
    begin
        covgrp = new();
    end
    endfunction

    task run;
    transaction trx;
    begin
        trx = new;
        forever begin
            gen2col_mbx.get(trx);
            covgrp.rst_n = trx.rst_n;
            covgrp.enable = trx.enable;
            covgrp.load = trx.load;
            covgrp.up_down_n = trx.up_down_n;
            covgrp.CovGrp.sample();
            ->col2gen_evt;
        end
    end
    endtask
endclass