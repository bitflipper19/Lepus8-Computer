// rough structure

module Control_Unit(
    input [2:0] Tstate,
    input [7:0] opcode,
    input ZF, CF, BF,

    output reg T_RST_N,

    output reg PC_INC, PC_JMP, PC_RD, PC_IR_RST_N, PC_OP_FETCH,
    
    output reg WR_HB, WR_LB, RD_LB, S_LB,

    output reg A_RD, A_WR, B_RD, B_WR, C_RD, C_WR,
    output reg ENA_A, ENA_B, ALU_RD, 

    output reg ADDR_RD, ADDR_WR, DATA_RD, DATA_WR,
    output reg STACK_PUSH, STACK_POP,

    output reg RO, RI, ADDR 
    // And some more signals
);
    localparam T0 = 3'b000,
               T1 = 3'b001,
               T2 = 3'b010,
               T3 = 3'b011,
               T4 = 3'b100,
               T5 = 3'b101,
               T6 = 3'b110,
               T7 = 3'b111;

    always @(*) begin
        // default assignment

        // Instruction Fetch
        PC_RD=1'b0; PC_OP_FETCH=1'b1; RI=1'b0; ADDR=1'b0;
        RO=1'b0; WR_HB=1'b0; WR_LB=1'b0; PC_INC=1'b0;


        casez({opcode, Tstate})
            {8'b?, T0}: begin
                PC_RD=1'b1; 
                PC_OP_FETCH=1'b1; 
                RI=1'b1;
                ADDR=1'b1;
            end


            {8'b?, T1}: begin
                RO=1'b1; 
                WR_HB=1'b1;
            end

            {8'b?, T2}: begin
                PC_RD=1'b1; 
                // PC_OP_FETCH=1'b0; 
                RI=1'b1;
                ADDR=1'b1;
            end

            {8'b?, T3}: begin
                RO=1'b1; 
                WR_LB=1'b1;
                PC_INC=1'b1;
            end


        endcase
    end

endmodule

    // // The Instruction fetch control logic, all signals update at negative edge 
    // // because the Tstate counter is negedge triggered 
    // // So that at the posedge when the units who actually need these signals 
    // // recieve a stable signal
    // always @(*) begin
    //     PC_RD=1'b0; PC_OP_FETCH=1'b1; RI=1'b0; ADDR=1'b0;
    //     RO=1'b0; WR_HB=1'b0; WR_LB=1'b0; PC_INC=1'b0;
    //     // basically "only" the signals responsible during Instruction Fetch
    //     // so I only instantiated them to zero and non other in the port list
    //     // First 4, T0 to T3 are for instruction fetch 
    //     case(Tstate)
    //         T0: begin 
    //             PC_RD=1'b1; 
    //             PC_OP_FETCH=1'b1; 
    //             RI=1'b1;
    //             ADDR=1'b1;
    //         end

    //         T1: begin
    //             RO=1'b1; 
    //             WR_HB=1'b1;
    //         end

    //         T2: begin
    //             PC_RD=1'b1; 
    //             // PC_OP_FETCH=1'b0; 
    //             RI=1'b1;
    //             ADDR=1'b1;
    //         end

    //         T3: begin
    //             RO=1'b1; 
    //             WR_LB=1'b1;
    //             PC_INC=1'b1;
    //         end

    //         // Not adding a default because cases of T4 to T7 are manged elsewhere
    //     endcase
    // end

    // // This block is essentially what differs one instruction from other
    // // as different blocks have different signals acting 
    // always @(*) begin
    //     PC_IR_RST_N=1'b1; ALU_RD=1'b0; T_RST_N=1'b1;
    //     // instantiate all the left signals
    //     case(opcode)
    //         8'd0: begin // NOP 16'd0
    //             case(Tstate)
    //                 T4: begin PC_IR_RST_N=1'b0; ALU_RD=1'b1; end
    //                 T5: T_RST_N=1'b0;
    //             endcase
    //         end

    //         8'd1: begin // 

    //         end

    //         // and so on
    //     endcase
    // end
