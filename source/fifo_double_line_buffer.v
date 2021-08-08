`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/10 16:15:05
// Design Name: 
// Module Name: fifo_double_line_buffer
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


module fifo_double_line_buffer(
    input clk,
    input rst,
    input we_i,
    input [7:0] data_i,

    output [7:0] data0_o,
    output [7:0] data1_o,
    output [7:0] data2_o,
    output done_o
    );

    parameter DEPTH = 640; 

    wire [7:0] fifo1_data_o, fifo2_data_o;
    wire fifo1_done_o;

    assign data0_o = data_i;
    assign data1_o = fifo1_data_o;
    assign data2_o = fifo2_data_o;
    assign done_o = fifo1_done_o;

    
    fifo_single_line_buffer #(.DEPTH(DEPTH)) BUFFER1(
        .clk(clk),
        .rst(rst),
        
        .we_i(we_i),
        .data_i(data_i),
        
        .data_o(fifo1_data_o),
        .done_o(fifo1_done_o)
    );
    fifo_single_line_buffer #(.DEPTH(DEPTH)) BUFFER2(
        .clk(clk),
        .rst(rst),
        
        .we_i(fifo1_done_o),
        .data_i(fifo1_data_o),
        
        .data_o(fifo2_data_o),
        .done_o()
    );    


endmodule
