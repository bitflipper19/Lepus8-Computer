module program_counter(
    inout [7:0] bus,
    input rd, jmp, inc, clk, rst_n, op_fetch
);
    reg [7:0] pc;
    wire [7:0] pc_n;
    wire [7:0] pc_out;
    always @(posedge clk) begin
        if(!rst_n) pc<=8'h00;
        else if(inc) pc<=pc+8'h02;
        else if(jmp) pc<=bus;
    end
    assign pc_n=pc+8'h01;
    assign pc_out=op_fetch? pc: pc_n;
    assign bus=rd? pc_out: 8'bz;
    
endmodule