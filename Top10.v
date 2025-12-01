
module Top10(clk, rst,adr1,adr2, result);
input clk, rst;
input [2:0] adr1,adr2;
output [7:0] result;

//cu wires
wire w_rf;
wire w_ram;
wire [2:0] adr_to_rom;
wire [2:0] adr_to_ram;
wire DA,SA,SB;
//rom wires
wire [3:0]rom_data;
//rf wires
wire [3:0]A;
wire [3:0]B;
//comb mult
wire [7:0] product;



cu uut(.clk(clk), .reset(rst),.adr1(adr1),.adr2(adr2),
.w_rf(w_rf),.adr(adr_to_rom),.DA(DA),.SA(SA),.SB(SB),.st_out(),
.w_ram(w_ram),.adr_ram(adr_to_ram));

ROM10 uut2(.ROM_data(rom_data),.ROM_addr(adr_to_rom));
RF uut3(.A(A), .B(B), .SA(SA), .SB(SB), .D(rom_data), .DA(DA), .W(w_rf), .rst(rst), .clk(clk));
CombinationalMult uut4(.a(A),.b(B),.product(product));
RAM10 uut5(.i_clk(clk), .i_rst(rst), .i_write_en(w_ram), .i_addr(adr_to_ram),
 .i_write_data(product), .o_read_data(result));
endmodule
