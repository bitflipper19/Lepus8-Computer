module Instruction_Fetch(
    inout [7:0] bus,
    output [7:0] opcode,
    input WR_HB, WR_LB, RD_LB,
    input PC_INC, PC_JMP, PC_RD, PC_IR_RST,
    input clk
);

    program_counter pc(
        .bus(bus),
        .rd(PC_RD),
        .inc(PC_INC),
        .jmp(PC_JMP),
        .clk(clk),
        .rst_n(PC_IR_RST)
    );

    instruction_register ir(
        .bus(bus),
        .opcode(opcode),
        .WR_HB(WR_HB),
        .WR_LB(WR_LB),
        .RD_LB(RD_LB),
        .clk(clk),
        .rst_n(PC_IR_RST)
    );

endmodule