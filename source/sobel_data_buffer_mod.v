`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/12 17:09:41
// Design Name: 
// Module Name: sobel_data_buffer_mod
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


module sobel_data_buffer_mod(
    input       clk,
    input       rst,
    input       done_i,
    input       [7:0] grayscale_i,

    output      [7:0] d0_o, d1_o, d2_o, d3_o, d4_o, d5_o, d6_o, d7_o, d8_o,
    output      done_o
    );

    parameter   ROWS = 400;
    parameter   COLS = 400;
    
    wire [7:0]  double_line_fifo_d0, double_line_fifo_d1, double_line_fifo_d2;
    wire        double_line_fifo_done;

    fifo_double_line_buffer #(.DEPTH(COLS)) SOBEL_DOUBLE_LINE_BUFFER(
        .clk(clk),
        .rst(rst),
        .we_i(done_i),
        .data_i(grayscale_i),

        .data0_o(double_line_fifo_d0),
        .data1_o(double_line_fifo_d1),
        .data2_o(double_line_fifo_d2),

        .done_o(double_line_fifo_done)
    ); 

    sobel_data_mod #(.ROWS(ROWS), .COLS(COLS)) SOBEL_DATA_MOD(
        .clk(clk),
        .rst(rst),

        .d0_i(double_line_fifo_d0),
        .d1_i(double_line_fifo_d1),
        .d2_i(double_line_fifo_d2),

        .done_i(double_line_fifo_done),

        .d0_o(d0_o), .d1_o(d1_o), .d2_o(d2_o), .d3_o(d3_o), .d4_o(d4_o), .d5_o(d5_o), .d6_o(d6_o), .d7_o(d7_o), .d8_o(d8_o),
        .done_o(done_o)
    );
endmodule
