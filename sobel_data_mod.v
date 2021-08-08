`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/12 13:45:00
// Design Name: 
// Module Name: sobel_data_mod
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


module sobel_data_mod(
    input clk,
    input rst,

    input [7:0] d0_i,
    input [7:0] d1_i,
    input [7:0] d2_i,

    input done_i,

    output reg [7:0] d0_o, d1_o, d2_o, d3_o, d4_o, d5_o, d6_o, d7_o, d8_o,
    output done_o
    );

    parameter ROWS = 480;
    parameter COLS = 640;

    reg [9:0] row, col;
    reg [7:0] data0, data1, data2, data3, data4, data5, data6, data7, data8;
    reg [7:0] counter;
    
    assign done_o = (counter == 2) ? 1 : 0;


//-----------calculate current pixel's row, col----------

    always @(posedge clk ) begin
        if(rst) begin
            row <= 0;
            col <= 0;
        end else begin
            if(done_o) begin
                col <= (col == COLS-1) ? 0 : col + 1;
                if(col == COLS-1) begin
                    row <= (row == ROWS - 1) ? 0 : row + 1;
                end
            end
        end
    end

//-----------calculate output data-----------------------
//-----------calculate edge cases------------------------

    always @(*) begin
        if (rst) begin
            d0_o <= 0;                      //-----------d0 d1 d2-----------
            d1_o <= 0;                      //-----------d3 d4 d5-----------
            d2_o <= 0;                      //-----------d6 d7 d8-----------
            d3_o <= 0; 
            d4_o <= 0; 
            d5_o <= 0; 
            d6_o <= 0; 
            d7_o <= 0; 
            d8_o <= 0;
        end else begin
            if(done_o) begin
                if(row == 0 && col ==0) begin
                    d0_o <= 0;              //-----------0  0  0-----------
                    d1_o <= 0;              //-----------0  d4 d5-----------
                    d2_o <= 0;              //-----------0  d7 d8-----------
                    d3_o <= 0; 
                    d4_o <= data4; 
                    d5_o <= data5; 
                    d6_o <= 0; 
                    d7_o <= data7; 
                    d8_o <= data8;                    
                end else if(row == 0 && col != 0) begin
                    d0_o <= 0;              //-----------0  0  0-----------
                    d1_o <= 0;              //-----------d3 d4 d5-----------
                    d2_o <= 0;              //-----------d6 d7 d8-----------
                    d3_o <= data3; 
                    d4_o <= data4; 
                    d5_o <= data5; 
                    d6_o <= data6; 
                    d7_o <= data7; 
                    d8_o <= data8;                
                end else if (row == 0 && col == COLS - 1) begin
                    d0_o <= 0;              //-----------0  0  0-----------
                    d1_o <= 0;              //-----------d3 d4 0-----------
                    d2_o <= 0;              //-----------d6 d7 0-----------
                    d3_o <= data3; 
                    d4_o <= data4; 
                    d5_o <= 0; 
                    d6_o <= data6; 
                    d7_o <= data7; 
                    d8_o <= 0;
                end else if (row > 0 && row < ROWS-1 && col == 0) begin
                    d0_o <= 0;              //-----------0 d1 d2-----------
                    d1_o <= data1;          //-----------0 d4 d5-----------
                    d2_o <= data2;          //-----------0 d7 d8-----------
                    d3_o <= 0; 
                    d4_o <= data4; 
                    d5_o <= data5; 
                    d6_o <= 0; 
                    d7_o <= data7; 
                    d8_o <= data8;
                end else if(row > 0 && row < ROWS-1 && col == COLS-1) begin
                    d0_o <= data0;           //-----------d0 d1 0-----------
                    d1_o <= data1;           //-----------d3 d4 0-----------
                    d2_o <= 0;               //-----------d6 d7 0-----------
                    d3_o <= data3; 
                    d4_o <= data4; 
                    d5_o <= 0; 
                    d6_o <= data6; 
                    d7_o <= data7; 
                    d8_o <= 0;
                end else if (row > 0 && row < ROWS-1 && col > 0 && col < COLS-1) begin
                    d0_o <= data0;           //-----------d0 d1 d2-----------
                    d1_o <= data1;           //-----------d3 d4 d5-----------
                    d2_o <= data2;           //-----------d6 d7 d8-----------
                    d3_o <= data3; 
                    d4_o <= data4; 
                    d5_o <= data5; 
                    d6_o <= data6; 
                    d7_o <= data7; 
                    d8_o <= data8;
                end else if (row == ROWS-1 && col == 0) begin
                    d0_o <= 0;               //-----------0 d1 d2-----------
                    d1_o <= data1;           //-----------0 d4 d5-----------
                    d2_o <= data2;           //-----------0  0  0-----------
                    d3_o <= 0; 
                    d4_o <= data4; 
                    d5_o <= data5; 
                    d6_o <= 0; 
                    d7_o <= 0; 
                    d8_o <= 0;                    
                end else if (row == ROWS-1 && col > 0 && col < COLS-1) begin
                    d0_o <= data0;           //-----------d0 d1 d2-----------
                    d1_o <= data1;           //-----------d3 d4 d5-----------
                    d2_o <= data2;           //-----------0  0  0------------
                    d3_o <= data3; 
                    d4_o <= data4; 
                    d5_o <= data5; 
                    d6_o <= 0; 
                    d7_o <= 0; 
                    d8_o <= 0;                    
                end else if (row == ROWS-1 && col == COLS-1) begin
                    d0_o <= data0;           //-----------d0 d1 0-----------
                    d1_o <= data1;           //-----------d3 d4 0-----------
                    d2_o <= 0;               //-----------0  0  0-----------
                    d3_o <= data3; 
                    d4_o <= data4; 
                    d5_o <= 0; 
                    d6_o <= 0; 
                    d7_o <= 0; 
                    d8_o <= 0;
                end            
            end
        end
    end

    always @(posedge clk ) begin
        if (rst) begin
            data0 <= 0;
            data1 <= 0;
            data2 <= 0;
            data3 <= 0;
            data4 <= 0;
            data5 <= 0;
            data6 <= 0;
            data7 <= 0;
            data8 <= 0;            
        end else begin
            if (done_i) begin //begin shifting 
                data0 <= data1;
                data1 <= data2;
                data2 <= d2_i;

                data3 <= data4;
                data4 <= data5;
                data5 <= d1_i;

                data6 <= data7;
                data7 <= data8;
                data8 <= d0_i;
            end            
        end
    end
//-------------handle when to start calculate-----------------------
// When buffer1 done_o == 1, we already have the top two buffer filled ----------------------------------------------->   x o o o
// Therefore, in order to be able to start calculating, we only need the next                                             x o o o  "x" is the padding
// 2 pixel from the input. This would require at least 2 clk cycle(at the left most case), which is why we set            x ? ? 
// counter == 2.
    always @(posedge clk ) begin
        if (rst) begin
            counter <= 0;
        end else begin
            if (done_i) begin
                counter <= (counter == 2) ? counter : counter + 1;
            end else begin
                
            end
        end
    end
endmodule
