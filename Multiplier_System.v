`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2025 03:12:32 PM
// Design Name: 
// Module Name: Multiplier_System
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

module Multiplier_System(
input wire clk,
input wire rst,
output reg done,
output wire [7:0] result);

wire [3:0] rom_data;
reg [2:0] rom_addr;


ROM uu1(.ROM_data(rom_data),.ROM_addr(rom_addr));

wire [7:0] ram_read_data;
reg ram_we;
reg [2:0] ram_addr;
reg [7:0] ram_write_data;

RAM uu2(.i_clk(clk),.i_rst(rst),.i_write_en(ram_we),.i_addr(ram_addr),.i_write_en(ram_write_data),.o_read_data(ram_read_data));

reg [3:0] a_reg, b_reg;
wire [7:0] product;

CombinationalMult uu3(.a(a_reg),.b(b_reg),.product(product));
reg [7:0] prod_reg;
reg [1:0] pair_index;   
reg [7:0] result_reg;   
assign result = result_reg;

localparam S_IDLE    = 3'd0;
localparam S_READ_A  = 3'd1;
localparam S_READ_B  = 3'd2;
localparam S_CAPTURE = 3'd3;
localparam S_WRITE   = 3'd4;
localparam S_NEXT    = 3'd5;
localparam S_DONE    = 3'd6;
reg [2:0] state;
    always @(posedge clk) begin
        if (rst)begin
            state <= S_IDLE;
            rom_addr <= 3'd0;
            ram_addr <= 3'd0;
            ram_we <= 1'b0;
            a_reg <= 4'd0;
            b_reg <= 4'd0;
            prod_reg <= 8'd0;
            pair_index <= 2'd0;
            result_reg <= 8'd0;
            done <= 1'b0;
        end else begin
            case (state)
                S_IDLE: 
                begin
                    rom_addr <= 3'd0;
                    ram_addr <= 3'd0;
                    pair_index <= 2'd0;
                    ram_we <= 1'b0;
                    done <= 1'b0;
                    state <= S_READ_A;
                end
                S_READ_A: 
                begin
                    a_reg <= rom_data;
                    rom_addr <= rom_addr + 1;
                    state <= S_READ_B;
                end
                S_READ_B: 
                begin
                    b_reg <=rom_data;
                    state <=S_CAPTURE;
                end

                S_CAPTURE: begin
                    prod_reg <= product;
                    state <= S_WRITE;
                end
                S_WRITE: begin
                    ram_write_data <= prod_reg;
                    ram_we <= 1'b1;
                    result_reg <= prod_reg;
                    state <= S_NEXT;
                end
                S_NEXT: begin
                    ram_we <= 1'b0;
                    if (pair_index == 2'd3) begin
                        state <= S_DONE;
                    end else begin
                        pair_index <= pair_index + 1;
                        ram_addr <= ram_addr + 1;
                        rom_addr <= rom_addr + 1;
                        state <= S_READ_A;
                    end
                end
                S_DONE: begin
                    done <= 1'b1;
                end
                default: state <= S_IDLE;
            endcase
        end
    end
endmodule
