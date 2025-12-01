

module Top10_TB();
reg clk, rst;
reg [2:0] adr1,adr2;
wire [7:0] result;
Top10 uut(.clk(clk),.rst(rst),.adr1(adr1),.adr2(adr2),.result(result));

initial clk = 0;
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    #20;
    rst=0;
    adr1 = 3'b011;
    adr2 = 3'b011;
    #200;
    rst = 1;
    #20;
    rst=0;
    adr1 = 3'b101;
    adr2 = 3'b101;
    #200;
    rst = 1;
    #20;
    rst=0;
    adr1 = 3'b100;
    adr2 = 3'b100;
    #200;
    $stop;
end
endmodule
