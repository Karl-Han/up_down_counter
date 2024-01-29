class test;
    environment env;

    function new();
        env = new();
    endfunction

    virtual task run();
        env.run();
    endtask
endclass