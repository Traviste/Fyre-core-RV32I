`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2023 09:31:11 PM
// Design Name: 
// Module Name: COUNTER_tb
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


module COUNTER_tb(

    );
    reg CLK, RST, write;
    reg [31:0] addr;
    wire [31:0] curr, next;
    
    P_COUNTER UUT(.CLK (CLK), .RST(RST), .write(write),
                  .addr(addr),
                  .curr(curr), .next(next)); 
    always begin
        CLK = 1'b1;
        #10;
        CLK = 1'b0;
        #10;
    end

    initial begin
        RST = 1'b1;
        #20;
        RST = 1'b0;
        #10;
        
        write = 1'b1;
        addr = 32'h000AB4;
        #30;
        write = 1'b0;
        
    end
endmodule
