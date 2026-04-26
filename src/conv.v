`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2026 12:24:35 AM
// Design Name: 
// Module Name: conv
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


module conv(
                input               i_clk,
                input               i_rst,
                input [71:0]   i_pixel_data,
                input               i_pixel_data_valid,
                output reg [7:0]   o_convolved_data,
                output reg     o_convolved_data_valid
    );
    
    integer i;
    reg [7:0] kernel [8:0];
    reg [15:0] mult_data [8:0];
    
    reg [15:0] sum_data;
    reg [15:0]sumdata_temp;
    
    reg sum_datavalid;
    reg multDataValid;
    reg convolved_data_valid;
    
    // declaring kernel
     initial 
        begin
                for (i=0;i<9;i=i+1)
                begin
                        kernel[i]=1;
                end
      end
        
      // performing multiplication
      always @(posedge i_clk)
              begin
                      for (i=0;i<9;i=i+1)
                              begin
                                      mult_data[i] <= kernel[i] * i_pixel_data[i*8+:8] ;
                              end
                              multDataValid <= i_pixel_data_valid;
              end 
                
         always @(*)
                begin
                sumdata_temp = 0;
                        for (i=0;i<9;i=i+1)
                                begin
                                    sumdata_temp = mult_data[i] + sumdata_temp; // temp_sum = temp_sum + mult_data[i];  // sum_data <= temp_sum;
                                end
                end
                
        always @(posedge i_clk)
        begin
                sum_data <=sumdata_temp;
                sum_datavalid <= multDataValid;
        end
        
        always @(posedge i_clk)
        begin
                o_convolved_data <= sum_data/9 ;
                convolved_data_valid <= sum_datavalid;
        end
                
                

endmodule





