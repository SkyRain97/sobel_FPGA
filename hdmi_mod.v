`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/07 22:28:38
// Design Name: 
// Module Name: hdmi_mod
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


module hdmi_mod(
    input sys_clk_i,
    input sys_rst_i,

    input [7:0] red_i,
    input [7:0] green_i,
    input [7:0] blue_i,

    input done_i,

    output scl_o,
    inout sda_io,

    output clk_n_o,
    output clk_p_o,

    output [2:0] hdmi_data_o
    );
endmodule
