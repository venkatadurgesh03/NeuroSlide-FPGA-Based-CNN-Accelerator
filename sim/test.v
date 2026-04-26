`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2026 02:19:45 AM
// Design Name: 
// Module Name: test
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


module test(
                input clk,
                input rst,
                input  m0,
                input m1,
                output reg [4:0] res
    );
    
    reg [3:0] sum_data;
    always @(posedge clk)
    begin
                sum_data=0;
                sum_data = sum_data +m0;
                sum_data = sum_data +m1;
                res= sum_data;
    end
endmodule
