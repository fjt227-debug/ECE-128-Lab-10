`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2025 01:52:34 PM
// Design Name: 
// Module Name: anodeGenerator
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


module anodeGenerator(clk, bcd_in, seg_anode, bcd_out);
input  clk;           
input[15:0] bcd_in;  
output reg[3:0] seg_anode; 
output reg [3:0] bcd_out;
 
reg [9:0] g_count=0;
reg [3:0] anode;
initial begin
anode = 4'b1110;
end 
always @(posedge clk) begin
    g_count <= g_count + 1;

        // refresh delay
        if (g_count == 10'd1023) begin
            g_count <= 0;
            seg_anode <= anode;
            
            case (anode)
                4'b1110: bcd_out<= bcd_in[3:0];    
                4'b1101: bcd_out<= bcd_in[7:4];    
                4'b1011: bcd_out<=bcd_in[11:8];   
                4'b0111: bcd_out<= bcd_in[15:12]; 
                default: bcd_out<= 4'b0000;
            endcase

            //shift register
            anode <= {anode[0], anode[3:1]};
        end

    end
endmodule

