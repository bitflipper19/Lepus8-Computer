module tb;
    wire [7:0] bus;
    reg [7:0] driver;
    reg RD, WR, clk;

    assign bus = WR ? driver : 8'bz;

    register DUT(
        .bus(bus),
        .WR(WR),
        .RD(RD),
        .clk(clk)
    );

    initial begin
        RD = 1'b0; WR = 1'b0; clk = 1'b0;
        driver = 8'hxx;
    end

    always #5 clk = ~clk;

    initial begin
        $dumpfile("reg.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        @(negedge clk);
        driver = 8'hA0;
        WR = 1'b1;
        @(posedge clk);
        @(negedge clk);
        WR = 1'b0;

        @(posedge clk);
        driver = 8'h00;
        @(negedge clk);
        RD=1'b1;
        #6 RD=1'b0;

        #20 $finish;
    end
endmodule