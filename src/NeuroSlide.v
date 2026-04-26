`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2026 04:54:11 PM
// Design Name: 
// Module Name: live
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

module live(
    input clk,
    input rst,
    input data_valid,
    input [7:0] data
    );
     
    reg [7:0] kernel [8:0];             // this is kernel or filter
    reg [7:0] window [2:0][2:0];          //  this is the window that is being multiplied with kernel
    
    // declaring line buffers
    reg [7:0] linebuffer1 [3:0];
    reg [7:0] linebuffer2  [3:0];
    reg [7:0] linebuffer3 [3:0];
    integer i;
    reg [2:0]  k=0;
    reg [1:0] j=0;
    
    reg [15:0] sum;
    reg sum_valid;
    reg [15:0] result [3:0];
    reg [1:0] res_count=0;

    reg [3:0] addr=0 ;              // Address counter

    wire [7:0] pixel ;              // BRAM outputs 9-bit

    blk_mem_gen_0 bram (            //  BRAM instance   
        .clka(clk),
        .ena(1'b1),
        .wea(1'b0),
        .addra(addr),
        .douta(pixel)
    );
    
        reg we=1;
        reg [1:0] adk=0;
        wire [7:0] dout;
        reg done_writing=0;

    reg [1:0] count =0;
    reg [1:0] delay=0 ;

 // ===================================================================
        always @(posedge clk)                  // Bringing Data into line buffers
        begin
                addr <= addr + 1;
                if (delay < 2) 
                        begin
                                delay <= delay + 1; 
                        end
                else 
                        begin
                                linebuffer1 [count] <= pixel;
                                linebuffer2 [ count ] <= linebuffer1[count];
                                linebuffer3 [ count ] <= linebuffer2[count];
                                count <= count +1;
                        end 
                        
        end
  // ====================================================================
  
  // ====================================================================
        always @(posedge clk)                     // loading the window
        begin
                window[0][2]<=linebuffer3 [count];
                window[1][2]<=linebuffer2 [count];
                window[2][2]<=linebuffer1 [count];
                
                window [0][1] <= window[0][2];
                window [0][0] <= window[0][1];
                window [1][1] <= window[1][2];
                window [1][0] <= window[1][1];
                window [2][1] <= window[2][2];
                window [2][0] <= window[2][1];
                
        end
// =======================================================================


// ====================================================================
        always @(*)                   // multiplying the kernel
        begin
                sum = window[0][0]*kernel[0] + window[0][1]*kernel[1] + window[0][2]*kernel[2] +
                window[1][0]*kernel[3] + window[1][1]*kernel[4] + window[1][2]*kernel[5] +
                window[2][0]*kernel[6] + window[2][1]*kernel[7] + window[2][2]*kernel[8];
        end
        
        always @(posedge clk)           // initializing sum_valid
        begin
                if(k>2 && j>=2 && done_writing==0)
                        sum_valid<=1;
                 else
                        sum_valid<=0;
        end
        
        always @(posedge clk)           //  loading output into bram
        begin
                if (sum_valid==1 )
                begin
                        adk<=adk+1;
                end          
        end
        
        always @(posedge clk)
        begin
                if(adk==3)
                        begin
                                sum_valid<=0;
                                done_writing<=1;
                        end
        end

        
        always @(posedge clk)
        begin
                if (done_writing==1)
                        adk<=adk+1;
        end
        
        always @(posedge clk)                           // printing values in a register
        begin
                if (sum_valid==1)
                begin
                        result[res_count]<=sum;
                        res_count <= res_count+1;
                end
        end
// =======================================================================

        always @(posedge clk)                   // changing k, j values 
                begin
                        if (delay==2)
                                j<=j+1;
                        if (j==3)
                                k<=k+1;
                end
    
// =======================================================================
    initial             // declaring kernel = 1
        begin
                for (i=0;i<9;i=i+1)
                        begin
                                kernel[i]=1;
                        end
        end 
// =======================================================================    



// ======================================================================= 
    stage1_kernel_op kernel1(                   // stores output of kernel 1
        .clka(clk),
        .ena(1'b1),
        .wea(sum_valid),
        .addra(adk),
        .dina(sum[7:0]),
        .douta(dout)
    );
 // =======================================================================    

endmodule
