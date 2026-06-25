module lepusALU(
    output [7:0] result,
    output [1:0] flag,
    input [7:0] operand_a, operand_b,
    input [4:0] opcode,
);
    always @(*) begin
        case(op) 
            // ALU Logic Here
        endcase
    end
    
endmodule