`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2025 02:57:33 PM
// Design Name: 
// Module Name: Top_MatrixMult_Display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top_MatrixMult_Display(
input  wire clk,           
input  wire rst,          
output wire [3:0] seg_anode,
output wire [6:0] seg_cathode);

wire done;
wire [7:0] result_bin;   

Multiplier_System uu1(.clk(clk),.rst(rst),.done(done),.result(result_bin));
reg [11:0] bin_d_in;    
wire [15:0] bcd_d_out;
wire rdy;
reg en;
reg done_pipe;
reg [15:0] stat_bcd;

always @(posedge clk) begin
    {en, done_pipe} <= {done_pipe, done};
end

always @(posedge clk) begin
    bin_d_in <= {4'b0000, result_bin};
end

Bin12to16BCD uu2(.clk(clk),.en(en),.bin_d_in(bin_d_in),.bcd_d_out(bcd_d_out),.rdy(rdy));
always @(posedge clk) begin
    if (rdy)
         stat_bcd <= bcd_d_out;
    end

multisegDriver uu3(.clk(clk),.bcd_in(stat_bcd),.seg_anode(seg_anode),.seg_cathode(seg_cathode));
endmodule
