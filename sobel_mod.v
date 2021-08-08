`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/07 22:28:38
// Design Name: 
// Module Name: sobel_mod
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


module sobel_mod(
    input clk,
    input rst,

    input [7:0] cam_red_i,
    input [7:0] cam_green_i,
    input [7:0] cam_blue_i,

    input cam_done_i,

    output [7:0] cam_red_o,
    output [7:0] cam_green_o,
    output [7:0] cam_blue_o,

    output sobel_done_o
    );

    parameter   ROWS = 400;
    parameter   COLS = 400;

    wire [7:0] rgb_to_grayscale_result;
    wire rgb_to_grayscale_done_o, sobel_kernel_done_o;
    wire [7:0] sobel_grayscale_o;

    rgb_to_grayscale RGB_TO_GRAYSCALE(
        .clk(clk),
        .rst(rst),

        .red_i(cam_red_i),
        .green_i(cam_green_i),
        .blue_i(cam_blue_i),

        .done_i(cam_done_i),

        .grayscale_o(rgb_to_grayscale_result),
        .done_o(rgb_to_grayscale_done_o)
    );

    sobel_kernel #(.ROWS(ROWS), .COLS(COLS)) SOBEL_KERNEL(
        .clk(clk),
        .rst(rst),

        .grayscale_i(rgb_to_grayscale_result),
        .done_i(rgb_to_grayscale_done_o),

        .grayscale_o(sobel_grayscale_o),
        .done_o(sobel_kernel_done_o) 
    );

    grayscale_to_rgb GRAYSCALE_TO_RGB(
        .clk(clk),
        .rst(rst),

        .grayscale_i(sobel_grayscale_o),
        .done_i(sobel_kernel_done_o),

        .red_o(cam_red_o),
        .green_o(cam_green_o),
        .blue_o(cam_blue_o),

        .done_o(sobel_done_o)
    );
endmodule
