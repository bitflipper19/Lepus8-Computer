module Instruction_Execute(
    inout [7:0] bus,
    output ZF, CF, BF,
    input [4:0] opcode,
    input A_RD, A_WR, B_RD, B_WR, C_RD, C_WR,
    input ENA_A, ENA_B, ALU_RD,
    input clk
);

    register reg_A(
        .bus(bus),
        .rd(A_RD),
        .wr(A_WR),
        .clk(clk)
    );

    register reg_B(
        .bus(bus),
        .rd(B_RD),
        .wr(B_WR),
        .clk(clk)
    );

    register reg_C(
        .bus(bus),
        .rd(C_RD),
        .wr(C_WR),
        .clk(clk)
    );

    LepusALU alu(
        .bus(bus),
        .ZF(ZF), .CF(CF), .BF(BF),
        .ENA_A(ENA_A), .ENA_B(ENA_B), .ALU_RD(ALU_RD),
        .opcode(opcode),
        .clk(clk)
    );

endmodule