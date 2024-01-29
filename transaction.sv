class transaction;
    rand logic rst_n;
    rand logic enable;
    rand logic load;
    rand logic up_down_n;
    rand logic [3:0] data_input;

    logic [3:0] data_output;

    function void print(string msg = "");
        $display("T=%0d %s: rst_n = %b, enable = %b, load = %b, up_down_n = %b, data_input = %h, data_output = %h", $time, msg, rst_n, enable, load, up_down_n, data_input, data_output);
    endfunction

    function transaction copy();
        copy = new;
        copy.rst_n = this.rst_n;
        copy.enable = this.enable;
        copy.load = this.load;
        copy.up_down_n = this.up_down_n;
        copy.data_input = this.data_input;
        copy.data_output = this.data_output;
    endfunction
endclass