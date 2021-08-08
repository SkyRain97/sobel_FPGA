`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/08 14:15:50
// Design Name: 
// Module Name: rgb_to_grayscale_tb
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
`define read_fileName  "F:\\Xilinx\\Projects\\real_time_sobel\\testBMP.bmp"
`define write_fileName "F:\\Xilinx\\Projects\\real_time_sobel\\result.bmp"


module rgb_to_grayscale_tb();

reg clk, rst;
reg [7:0] red_i,green_i,blue_i;
reg done_i;
wire [7:0] grayscale_o;
wire done_o;
//-----------------------------------------------------------------------
//Initialize a rgb2gray module 
//-----------------------------------------------------------------------    
rgb_to_grayscale RGB_TO_GRAYSCALE(    
    .clk(clk),
    .rst(rst),

    .red_i(red_i),
    .green_i(green_i),
    .blue_i(blue_i),

    .done_i(done_i),

    .grayscale_o(grayscale_o),
    .done_o(done_o)
    );


//-----------------------------------------------------------------------
//Generate clk for tb
//-----------------------------------------------------------------------
initial clk = 1'b1;
always #(`clk_period/2) clk = ~clk;

integer i;
localparam RESULT_ARRAY_LEN = 1000*1024;
reg [7:0] result[0:RESULT_ARRAY_LEN-1];

//-----------------------------------------------------------------------
//Load processed result from output of rgb2gray module. 
//-----------------------------------------------------------------------
integer j;
always @(posedge clk) begin
    if (rst) begin
        j <= 8'b0;
    end else begin
        if(done_o) begin
            result[j] <= grayscale_o;
            result[j+1] <= grayscale_o;
            result[j+2] <= grayscale_o;
            j <= j+3;
        end
    end    
end


localparam BMP_LEN = 1000*1024; // 1000 kb
reg [7:0] bmp_data[0:BMP_LEN-1];
integer bmp_size, bmp_start_pos, bmp_width, bmp_hight, biBitCount;

//-----------------------------------------------------------------------
//reading BMP file from local directory
//-----------------------------------------------------------------------
task readBMP;
    integer fileID, i;
    begin
        fileID = $fopen(`read_fileName, "rb");
        if (fileID == 0) begin
            $display("Failed to open BMP file \n");
            $finish;
        end else begin
            $fread(bmp_data, fileID);
            $fclose(fileID);

            bmp_size = {bmp_data[5],bmp_data[4],bmp_data[3],bmp_data[2]}; //bmp integer is stored in little-endian-> lsb comes first 
            $display("bmp_size = %d \n", bmp_size);
            
            bmp_start_pos = {bmp_data[13],bmp_data[12],bmp_data[11],bmp_data[10]};
            $display("bmp_start_pos = %d \n", bmp_start_pos);
            
            bmp_width = {bmp_data[21],bmp_data[20],bmp_data[19],bmp_data[18]};
            $display("bmp_width = %d \n", bmp_width);        
            
            bmp_hight = {bmp_data[25],bmp_data[24],bmp_data[23],bmp_data[22]};
            $display("bmp_hight = %d \n", bmp_hight);      
            
            biBitCount = {bmp_data[29],bmp_data[28]};
            $display("biBitCount = %d \n", biBitCount);
            
            if (biBitCount != 24) begin
                $display("bit count is not 24\n");
                $finish;
            end      
            if(bmp_width % 4)begin
                $display("bmp width does not equal to mutiplies of 4");
                $finish;
            end
            // for(i = bmp_start_pos; i<bmp_size; i = i+1) begin
            //     $display("%h", bmp_data[i]);
            // end     
        end
    end
endtask 


//-----------------------------------------------------------------------
//Writing BMP file to local directory from the processed result. 
//-----------------------------------------------------------------------
task writeBMP;
    integer fileID, i;
    begin
        fileID = $fopen(`write_fileName, "wb");

        for(i=0; i < bmp_start_pos; i=i+1) begin
            $fwrite(fileID, "%c", bmp_data[i]);
        end

        for(i=bmp_start_pos; i < bmp_size; i=i+1) begin
            $fwrite(fileID, "%c", result[i-bmp_start_pos]);
        end
        $fclose(fileID);
        $display("write bmp done!\n");
    end
endtask

initial begin

    rst     = 1'b1;
    done_i  = 1'b0;
    red_i   = 8'b0;
    green_i = 8'b0;
    blue_i  = 8'b0;

    # (`clk_period);
    rst = 1'b0;

    readBMP;
    
    for(i = bmp_start_pos; i< bmp_size; i=i+3) begin
        red_i   = bmp_data[i+2];
        green_i = bmp_data[i+1];
        blue_i  = bmp_data[i];     

        # (`clk_period);
        done_i = 1'b1;  
    end
    # (`clk_period);
    done_i = 1'b0;

    # (`clk_period);
    writeBMP;
    
    # (`clk_period);
    $stop; 


end

endmodule
