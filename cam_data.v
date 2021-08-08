`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/07 23:03:06
// Design Name: 
// Module Name: cam_data
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


module cam_data(
    input sys_clk_i,
    input sys_rst_i,

    input vsync_i,
    input href_i,
    input pclk_i,
    input [7:0] cam_data_i,

    output [7:0] cam_red_o,
    output [7:0] cam_green_o,
    output [7:0] cam_blue_o,

    output cam_done_o
    );
endmodule
