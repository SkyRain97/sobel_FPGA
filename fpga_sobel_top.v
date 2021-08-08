`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/07 22:12:05
// Design Name: 
// Module Name: fpga_sobel_top
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


module fpga_sobel_top(
    input sys_clk_i,
    input sys_rst_i,

    output xvclk_o,
    output sio_c_o,
    inout sio_d_io,
    output cam_rst_o,
    output cam_pwd_o,

    input vsync_i,
    input href_i,
    input pclk_i,
    input [7:0] cam_data_i,

    output scl_o,
    inout sda_io,

    output clk_n__o,
    output clk_p_o,

    output [2:0] hdmi_data_o
    );
endmodule
