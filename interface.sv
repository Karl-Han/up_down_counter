interface counter_interface;
    logic rst_n;
    logic enable;
    logic load;
    logic up_down_n;
    logic [3:0] data_input;

    logic [3:0] data_output;

    modport dut(
        input rst_n,
        input enable,
        input load,
        input up_down_n,
        input data_input,
        output data_output
    );

    modport drv(
        output rst_n,
        output enable,
        output load,
        output up_down_n,
        output data_input
    );

    modport mon(
        input rst_n,
        input enable,
        input load,
        input up_down_n,
        input data_input,
        input data_output
    );
endinterface

interface clk_interface;
    logic clk;
    logic pre_clk;

    initial clk = 0;
    always #10 clk = !clk;

    initial begin
        pre_clk = 0;
    end
    always @(clk) begin
        #4;
        pre_clk = !pre_clk;
    end
endinterface