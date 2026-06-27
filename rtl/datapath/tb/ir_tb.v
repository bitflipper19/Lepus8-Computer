module tb;
    wire [7:0] bus;
    wire [4:0] opcode; wire [2:0] sub_opcode;

    reg WR_1, WR_0, RD_0, clk, rst_n;
    reg [7:0] driver;

    assign bus = (WR_0|WR_1)? driver: 8'bz;

    instruction_register DUT(
        .bus(bus),
        .opcode(opcode),
        .sub_opcode(sub_opcode),
        .WR_0(WR_0), .RD_0(RD_0),
        .WR_1(WR_1), .clk(clk),
        .rst_n(rst_n)
    );

    initial begin
        WR_1=1'b0; 
        WR_0=1'b0;
        RD_0=1'b0;
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
        WR_1=1'b1;

        @(negedge clk)
        WR_1=1'b0;

        @(posedge clk)
        driver=8'h85;

        @(negedge clk)
        WR_0=1'b1;

        @(negedge clk)
        WR_0=1'b0;

        @(posedge clk)
        driver=8'h00;

        @(negedge clk) 
        RD_0=1'b1;

        @(negedge clk)
        RD_0=1'b0;

        #10 $finish;
    end
endmodule