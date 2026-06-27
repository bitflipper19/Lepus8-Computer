module register(
    inout [7:0] bus,
    input RD,
    input WR,
    input clk
);
    reg [7:0] A;
    always @(posedge clk) begin
        if(WR) A<=bus;
        else A<=A;
    end 

    assign bus=RD? A: 8'bz;
    
endmodule