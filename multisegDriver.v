`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2025 01:51:04 PM
// Design Name: 
// Module Name: multisegDriver
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


module multisegDriver(
input clk,
input [15:0] bcd_in,
output [3:0] seg_anode,
output [6:0] seg_cathode);

wire [3:0] bcd_val;

anodeGenerator u1 (.clk(clk),.bcd_in(bcd_in), .seg_anode(seg_anode), .bcd_out(bcd_val));
BCDtoSevenSegmentDisplay1 u2 (.data_in(bcd_val),.seg(seg_cathode) ); 

endmodule
