module MEM_stage(
    inout [7:0] bus,
    input ADDR_RD, ADDR_WR, DATA_RD, DATA_WR,
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

endmodule