module instruction_register(
    inout [7:0] bus,
    output [4:0] opcode,
    output [2:0] sub_opcode,

    input WR_1, WR_0,
    input RD_0,
    input clk, rst_n
);

    reg [15:0] IR;
    always @(posedge clk) begin
        if(!rst_n) IR<=16'h0000;
        else begin
            if(WR_1) IR[15:8]<=bus;
            else if(WR_0) IR[7:0]<=bus;
            else IR<=IR; 
        end
    end

    assign bus=RD_0? IR[7:0]: 8'bz;
    assign opcode=IR[15:11];
    assign sub_opcode=IR[10:8];

endmodule