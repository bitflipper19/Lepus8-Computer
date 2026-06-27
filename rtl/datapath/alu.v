module LepusALU(
    output reg [7:0] result,
    output reg ZF,
    output reg CF,
    output reg BF,
    input signed [7:0] a,
    input signed [7:0] b,
    input [4:0] opcode
);

    localparam ADD = 5'b01010,
               SUB = 5'b01011,
               XOR = 5'b01100,
               OR  = 5'b01101,
               AND = 5'b01110,
               SHR = 5'b01111,
              ASHR = 5'b10000,
               SHL = 5'b10001;

    wire sub = (opcode == SUB);

    wire [7:0] b_xor = b ^ {8{sub}};
    wire [8:0] sum = a + b_xor + sub;

    always @(*) begin
        result = 8'h00;
        CF = 1'b0;
        BF = 1'b0;
        ZF = 1'b0;

        case (opcode)

            ADD: begin
                result = sum[7:0];
                CF = sum[8];
            end

            SUB: begin
                result = sum[7:0];
                BF = ~sum[8];
            end

            XOR: result = a ^ b;
             OR: result = a | b;
            AND: result = a & b;

            SHR: result = a >> b;
           ASHR: result = a >>> b;
            SHL: result = a << b;

            default: result = 8'h00;
        endcase

        ZF = (result == 8'h00);
    end

endmodule