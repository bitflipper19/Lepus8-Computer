module ctr(
    output reg [2:0] count,
    input clk, rst_n
);

    always @(posedge clk) begin
        if(!rst_n) count<=3'b0;
        else count<=count+1'b1;     
    end
    
    
endmodule