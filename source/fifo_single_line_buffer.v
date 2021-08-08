`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/10 14:05:45
// Design Name: 
// Module Name: fifo_single_line_buffer
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


module fifo_single_line_buffer(
    input clk,
    input rst,
    
    input we_i,
    input [7:0] data_i,
    
    output [7:0] data_o,
    output done_o
    );

    parameter DEPTH = 640;
    reg [7:0] mem [0:DEPTH-1]; 
    reg [9:0] wr_pointer;               //2^9 <640 <2^10 therefore need 10 bits
    reg [9:0] rd_pointer;
    
    reg [9:0] iCounter;

    assign done_o = (iCounter == DEPTH) ? 1 : 0;
    assign data_o = mem[rd_pointer];

    //---------------Icounter---------------------
    always @(posedge clk) begin
        if (rst) begin
            iCounter <= 0;
        end else begin
            if(we_i == 1) begin
                iCounter <= (iCounter == DEPTH) ? iCounter : iCounter + 1;
            end
        end
    end

    //-------------write process------------------
    always @(posedge clk ) begin
        if (rst) begin
            wr_pointer <= 0;
        end else begin
            if(we_i == 1) begin
                mem[wr_pointer] <= data_i;
                wr_pointer <= (wr_pointer == DEPTH - 1) ? 0 : wr_pointer + 1;
            end
        end
    end

    //-------------read process------------------
    always @(posedge clk ) begin
        if(rst) begin
            rd_pointer <= 0; 
        end else begin
            if(we_i == 1) begin
                if(iCounter == DEPTH) begin // wait until the fifo is full to begin reading
                    rd_pointer <= (rd_pointer == DEPTH - 1)? 0 : rd_pointer + 1;
                end 
            end
        end
    end
endmodule
