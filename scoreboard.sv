class scoreboard;
    mailbox mon2sco_mbx;

    task run();
    begin
        transaction trx, tmp, prev_trx;
        forever begin
            mon2sco_mbx.get(tmp);
            trx = tmp.copy();
            trx.print("Scoreboard");

            if(trx.rst_n == 1'b0) begin
                // reset enabled
                if(trx.data_output == 4'h0)
                    $display("[%0t] Scoreboard Pass! Output is 4'h0 on rst_n = 1'b0", $time);
                else
                    $display("[%0t] Scoreboard Fail! Output is %h on rst_n = 1'b0", $time, trx.data_output);
            end
            else begin
                // reset disabled
                if(trx.enable == 1'b0) begin
                    // counter enabled
                    if(trx.data_output == prev_trx.data_output)
                        $display("[%0t] Scoreboard Pass! Output match previous on enable = 1'b0", $time);
                    else
                        $display("[%0t] Scoreboard Fail! Output is %h not matching %h on enable = 1'b0", $time, trx.data_output, prev_trx.data_output);
                end
                else begin
                    // counter disabled
                    if(trx.load == 1'b1) begin
                        // load enabled
                        if(trx.data_output == trx.data_input)
                            $display("[%0t] Scoreboard Pass! Output match previous on load = 1'b1", $time);
                        else
                            $display("[%0t] Scoreboard Fail! Output is %h not matching %h on load = 1'b1", $time, trx.data_output, trx.data_input);
                    end
                    else begin
                        // load disabled
                        logic [3:0] temp;
                        if(trx.up_down_n == 1'b0) begin
                            temp = prev_trx.data_output -1;
                            // counting down
                            if(trx.data_output == temp)
                                $display("[%0t] Scoreboard Pass! Output match counting up on up_down_n = 1'b0", $time);
                            else
                                $display("[%0t] Scoreboard Fail! Output is %h not matching %h on up_down_n = 1'b0", $time, trx.data_output, prev_trx.data_output -1);
                        end
                        else begin
                            temp = prev_trx.data_output +1;
                            // counting up
                            if(trx.data_output == temp)
                                $display("[%0t] Scoreboard Pass! Output match counting down on up_down_n = 1'b1", $time);
                            else
                                $display("[%0t] Scoreboard Fail! Output is %h not matching %h on up_down_n = 1'b1", $time, trx.data_output, prev_trx.data_output +1);
                        end
                    end
                end
            end
            prev_trx = trx;
        end
    end
    endtask
endclass