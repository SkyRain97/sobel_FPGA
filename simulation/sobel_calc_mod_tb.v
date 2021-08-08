`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/14 14:09:51
// Design Name: 
// Module Name: sobel_calc_mod_tb
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

`define clk_period 10
module sobel_calc_mod_tb();

reg clk, rst, done_i;
reg [7:0] d0_i, d1_i, d2_i, d3_i, d4_i, d5_i, d6_i, d7_i, d8_i;

wire [7:0] grayscale_o;
wire done_o;

initial clk = 1'b1;
always #(`clk_period/2) clk = ~clk;

initial begin
    rst = 1;
    done_i = 0;

    #(`clk_period);

    rst = 1'b0;
    done_i = 1'b1;

    d0_i = 8'd1;
    d1_i = 8'd2;
    d2_i = 8'd3;
    d3_i = 8'd4;
    d4_i = 8'd5;
    d5_i = 8'd6;
    d6_i = 8'd7;
    d7_i = 8'd8;
    d8_i = 8'd9;

    //gx_d = d6 + d3*2 + d0 - (d8 + d5*2 + d2) ---> -8
    //gy_d = d0 + d1*2 + d2 - (d6 + d7*2 + d8) ---> 24
    //g_sum = |gy| + |gx| = 32


    #(`clk_period * 8)
    done_i = 1'b0;
    $stop;  

end

sobel_calc_mod SOBEL_CALC_MOD(
    .clk(clk),
    .rst(rst),
    .d0_i(d0_i), .d1_i(d1_i), .d2_i(d2_i), .d3_i(d3_i), .d4_i(d4_i), .d5_i(d5_i), .d6_i(d6_i), .d7_i(d7_i), .d8_i(d8_i),
    .done_i(done_i),

    .grayscale_o(grayscale_o),
    .done_o(done_o)
);
endmodule
