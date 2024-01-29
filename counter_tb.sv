import test_pkg::*;

`include "counter.sv"

module tb;
    clk_interface clk_intf();
    counter_interface ctr_intf();
    counter ctr(
        .clk(clk_intf.clk),
        .rst_n(ctr_intf.rst_n),
        .enable(ctr_intf.enable),
        .load(ctr_intf.load),
        .up_down_n(ctr_intf.up_down_n),
        .data_input(ctr_intf.data_input),
        .data_output(ctr_intf.data_output)
    );

    initial begin
        test t0;

        t0 = new;
        t0.env.ctr_intf = ctr_intf;
        t0.env.clk_intf = clk_intf;
        t0.run();

        // Once the main stimulus is over, wait for some time
        // until all transactions are finished and then end
        // simulation. Note that $finish is required because
        // there are components that are running forever in
        // the background like clk, monitor, driver, etc
        #50 $stop;
    end
endmodule
