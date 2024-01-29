// Write a SystemVerilog module for a 4-bit synchronous up/down counter with 
// - enable
// - asynchronous reset
// - synchronous load
// a testbench to verify your counter.
// Show simulation results in your favorite simulator. 
// Also provide a paragraph describing the most interesting hardware or software project that you have completed.

module counter(
    input logic clk,
    input logic rst_n,

    input logic enable,
    input logic load,
    input logic up_down_n,
    input logic [3:0] data_input,

    output logic [3:0] data_output
);

always_ff @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)
        data_output <= 4'h0;
    else begin
        if(enable == 1'b0)
            // disabled
            data_output <= data_output;
        else begin
            // enabled
            if(load == 1'b1) begin
                // load enabled
                data_output <= data_input;
            end
            else begin
                if(up_down_n == 1'b1)
                    // counting upward
                    data_output <= data_output +1;
                else
                    // counting downward
                    data_output <= data_output -1;
            end
        end
    end
end

endmodule