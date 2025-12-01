`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2025 08:02:16 PM
// Design Name: 
// Module Name: cu
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


module cu ( 
    input clk,
    input reset,
    input  [2:0] adr1,
    input  [2:0] adr2,
    output reg       w_rf,
    output reg [2:0] adr,
    output reg       DA,
    output reg       SA,
    output reg       SB,
    output reg [2:0] st_out,
    //output reg done,
    output reg [2:0] w_ram
);

parameter S0_idle=3'd0,S1_send_adr1=3'd1,S2_send_adr2=3'd2,S3_multiply=3'd3,S4_write_ram=3'd4,S5_read_ram=3'd5;
reg [2:0] PS, NS;

always @(posedge clk or posedge reset) 
begin
    if (reset)
        PS <= S0_idle;
    else
        PS <= NS;
end


always @(*) begin
    case (PS)
        S0_idle: begin
            NS = S1_send_adr1;
            w_rf = 1'b0;
            adr = 3'b000;
            DA = 1'b0;
            SA = 1'b0;
            SB = 1'b0;
            w_ram = 3'b000;
            st_out = 3'b000;
        end

        
        S1_send_adr1: begin
            NS = S2_send_adr2;
            w_rf = 1'b1;
            adr = adr1;
            DA = 1'b0;
            SA = 1'b0;
            SB = 1'b1;
            w_ram = 3'b000;   
            st_out = 3'b001;
        end
        
        S2_send_adr2: begin
            NS = S3_multiply;
            w_rf = 1'b1;     
            adr = adr2;
            DA = 1'b1;
            SA = 1'b0;
            SB = 1'b1;
            w_ram = 3'b000;
            st_out = 3'b010;
        end

        S3_multiply: begin
            NS = S4_write_ram; 
            w_rf = 1'b0;
            adr = 3'b000;
            DA = 1'b0;
            SA = 1'b0;
            SB = 1'b0;
            w_ram = 3'b000;   
            st_out = 3'b011;
        end

        S4_write_ram: begin
            NS = S5_read_ram;
            w_rf = 1'b0;
            adr = 3'b000;
            DA = 1'b0;
            SA = 1'b0;
            SB = 1'b0;
            w_ram = 3'b001;  
            st_out = 3'b100;
        end

        S5_read_ram: begin
            if (!reset)
                NS = S5_read_ram;
            else
                NS = S0_idle;
            w_rf = 1'b0;
            adr = 3'b000;
            DA = 1'b0;
            SA = 1'b0;
            SB = 1'b0;
            w_ram = 3'b010;   
            st_out = 3'b101;
        end
    endcase
end

endmodule
