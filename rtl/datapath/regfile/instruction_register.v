module instruction_register(
    inout [7:0] bus,
    output [7:0] opcode,

    input WR_HB, WR_LB,
    input RD_LB,
    input clk, rst_n
);

    reg [15:0] IR;
    always @(posedge clk) begin
        if(!rst_n) IR<=16'h0000;
        else begin
            if(WR_HB) IR[15:8]<=bus;
            else if(WR_LB) IR[7:0]<=bus;
            else IR<=IR; 
        end
    end

    assign bus=RD_LB? IR[7:0]: 8'bz;
    assign opcode=IR[15:8];
endmodule