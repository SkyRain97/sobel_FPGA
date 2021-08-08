`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/07 23:03:06
// Design Name: 
// Module Name: rgb_to_grayscale
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


module rgb_to_grayscale(
    input clk,
    input rst,

    input [7:0] red_i,
    input [7:0] green_i,
    input [7:0] blue_i,

    input done_i,

    output reg [7:0] grayscale_o,
    output reg done_o
    );  



    //////////////////////////////////////////////////////////////////////////////////
    // gray = 0.3*R + 0.59*G + 0.11*B
    // To avoid floating point arithmetic calculation, 2 methods:
    // 1: Scale and rescale
    //  1024 * 0.3 = 307.2, 1024 * 0.59 = 604.16, 1024 * 0.11 = 112.64
    //  Y = (307R + 604G + 113B) >> 10
    // 2: Shift
    //  Y = 0.3*R + 0.59*G + 0.11*B
    //  Y = (R>>2) + (R>>5) + (G>>1) + (G>>4) + (B>>4) + (B>>5)
    //  Y = (R/2^2) + (R/2^5) + (G/2) + (G/2^4) + B(2^4) + (B/2^5)
    //  Y = R*(0.25+0.03125) + G*(0.5+0.0625) + B*(0.0625+0.03215)
    //
    // method 2 only uses shift and no multiply so is more efficient 
    //////////////////////////////////////////////////////////////////////////////////

    always@(posedge clk) begin
        if (rst) begin
            grayscale_o <= 0;
            done_o <= 0;
        end else begin
            if (done_i == 1) begin
                grayscale_o <= (red_i>>2) + (red_i>>5) + (green_i>>1) + (green_i>>4) + (blue_i>>4) + (blue_i>>5);
                done_o <= 1;
            end else begin
                grayscale_o <= 0;
                done_o <= 0;
            end
        end

    end



endmodule
