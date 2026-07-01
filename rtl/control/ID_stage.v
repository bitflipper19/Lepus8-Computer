module Control_Unit(
    input [2:0] Tstate,
    input [7:0] opcode,
    input ZF, CF, BF,

    output PC_INC, PC_JMP, PC_RD, PC_IR_RST, PC_OP_FETCH,
    
    output WR_HB, WR_LB, RD_LB, 

    output A_RD, A_WR, B_RD, B_WR, C_RD, C_WR,
    output ENA_A, ENA_B, ALU_RD, 

    output ADDR_RD, ADDR_WR, DATA_RD, DATA_WR,
    output STACK_PUSH, STACK_POP,

    output RO, RI, ADDR 
);
    
endmodule