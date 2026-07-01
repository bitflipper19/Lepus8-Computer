// rough structure

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
    // And some more signals
);
    localparam T0 = 3'b0,
               T1 = 3'b1,
               T2 = 3'b2,
               T3 = 3'b3,
               T4 = 3'b4,
               T5 = 3'b5,
               T6 = 3'b6;
    
    // The Instruction fetch control logic, all signals update at negative edge 
    // because the Tstate counter is negedge triggered 
    // So that at the posedge when the units who actually need these signals 
    // recieve a stable signal
    always @(*) begin
        PC_RD=1'b0; PC_OP_FETCH=1'b1; RI=1'b0; ADDR=1'b0;
        RO=1'b0; WR_HB=1'b0; WR_LB=1'b0;
        // basically "only" the signals responsible during Instruction Fetch
        // so I only instantiated them to zero and non other in the port list
        // First 4, T0 to T3 are for instruction fetch 
        case(Tstate)
            T0: begin 
                PC_RD=1'b1; 
                PC_OP_FETCH=1'b1; 
                RI=1'b1;
                ADDR=1'b1;
            end

            T1: begin
                RO=1'b1; 
                WR_HB=1'b1;
            end

            T2: begin
                PC_RD=1'b1; 
                PC_OP_FETCH=1'b0; 
                RI=1'b1;
                ADDR=1'b1;
            end

            T3: begin
                RO=1'b1; 
                WR_LB=1'b1;
            end

            // Not adding a default because cases of T4 to T7 are manged elsewhere
        endcase
    end

    // This block is essentially what differs one instruction from other
    // as different blocks have different signals acting 
    always @(*) begin
        // instantiate all the left signals
        case(opcode)
            7'b0: begin
                case(Tstate)
                    T4: // Instruction specific signals
                    // starting from T4 because T0-T3 were for fetch
                    T5: // do some thing
                    // etc
                endcase
            end

            7'b1: begin
                // Instruction specific signals
            end

            // and so on
        endcase
    end

    
    
endmodule