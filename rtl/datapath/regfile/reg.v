module register(
    inout [7:0] bus,
    input rd,
    input wr,
    input clk
);
    reg [7:0] A;
    always @(posedge clk) begin
        if(wr) A<=bus;
        else A<=A;
    end 

    assign bus=rd? A: 8'bz;
    
endmodule