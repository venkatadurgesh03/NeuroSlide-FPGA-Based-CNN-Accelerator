`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2026 07:48:31 PM
// Design Name: 
// Module Name: linebuffer
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

module linebuffer(
            input           i_clk,
            input           i_rst,
            input [7:0]  i_data,
            input           i_data_valid,
            input           i_rd_valid,
            output [23:0] o_data,
            input           i_rd_data    
    );
 
 // image size is 512*512   
 reg [7:0] line [511:0];   // line  buffer  --> 512 mem locations with each 8 bit 
 reg [8:0] wrptr;
  reg [8:0] rdptr;
    
    always @(posedge i_clk)
    begin
            if(i_rst)
                        wrptr <= 0;
            else if (i_data_valid)
                        wrptr <= wrptr + 'd1;        
    end
    
    always @(posedge i_clk)
    begin
                if (i_data_valid)
                        line[wrptr] <= i_data;
    end
    
    assign o_data = {line[rdptr],line[rdptr+1],line[rdptr+2]};
    
    always @(posedge i_clk)
    begin
                if (i_rst)
                        rdptr <= 0;
                else if (i_rd_valid)
                        rdptr <= rdptr + 'd1;
    end
endmodule








