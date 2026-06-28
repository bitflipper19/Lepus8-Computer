module tb;
    wire [7:0] bus;
    wire [7:0] opcode;

    reg WR_HB, WR_LB, RD_LB, clk, rst_n;
    reg [7:0] driver;

    assign bus = (WR_LB|WR_HB)? driver: 8'bz;

    instruction_register DUT(
        .bus(bus),
        .opcode(opcode),
        .WR_LB(WR_LB), .RD_LB(RD_LB),
        .WR_HB(WR_HB), .clk(clk),
        .rst_n(rst_n)
    );

    initial begin
        WR_HB=1'b0; 
        WR_LB=1'b0;
        RD_LB=1'b0;
        rst_n=1'b0;
        clk=1'b1;
        driver=8'hAC;
    end

    always #5 clk=~clk;

    initial begin
        $dumpfile("ir.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        @(negedge clk)
        rst_n=1'b1;
        WR_HB=1'b1;

        @(negedge clk)
        WR_HB=1'b0;

        @(posedge clk)
        driver=8'h85;

        @(negedge clk)
        WR_LB=1'b1;

        @(negedge clk)
        WR_LB=1'b0;

        @(posedge clk)
        driver=8'h00;

        @(negedge clk) 
        RD_LB=1'b1;

        @(negedge clk)
        RD_LB=1'b0;

        #10 $finish;
    end
endmodule