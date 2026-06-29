module MEM_stage(
    inout [7:0] bus,
    input ADDR_RD, ADDR_WR, DATA_RD, DATA_WR,
    input STACK_PUSH, STACK_POP,
    input clk
);

    register memory_address_register(
        .bus(bus),
        .wr(ADDR_WR),
        .rd(ADDR_RD),
        .clk(clk)
    );

    register memory_data_register(
        .bus(bus),
        .wr(DATA_WR),
        .rd(DATA_RD),
        .clk(clk)
    );

    register stack_pointer(
        .bus(bus),
        .wr(STACK_PUSH),
        .rd(STACK_POP),
        .clk(clk)
    );

endmodule