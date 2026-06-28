module program_counter(
    inout [7:0] bus,
    input rd, jmp, inc, clk, rst_n
);
    reg [7:0] pc;
    always @(posedge clk) begin
        if(!rst_n) pc<=8'h00;
        else if(inc) pc<=pc+8'h02;
        else if(jmp) pc<=bus;
    end

    assign bus=rd? pc: 8'bz;
    
endmodule