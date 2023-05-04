`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2023 12:15:09 PM
// Design Name: 
// Module Name: REG_FILE
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


module REG_FILE(
input CLK, RST, W_EN,   //CLK, Reset, Write Enable
input [4:0] address, space1, space2,    //write and read (space) address
input [31:0] INIT,

output [31:0] REG1, REG2    //register output
    );
    //reg [15:0] read1, read2;
    
    integer i;
    reg [31:0] rmem[1:31];  //initialize 16 bit register file
    reg [31:0] rs1, rs2;
    
    assign REG1 = rs1;
    assign REG2 = rs2;
    always @(posedge CLK) begin
        if(RST) begin
        for( i = 1;  i < 32; i = i +1) begin
            rmem[i] <= 32'b0;    //set all values to 0
            end
        end
        else if(W_EN) begin    //write register value
            rmem[address] <= INIT;
        end
    end
    
    always @(*) begin
        rs1 = (space1 > 0) ? rmem[space1]:32'b0;  //greater than 0 read from external register else read 0 
        rs2 = (space2 > 0) ? rmem[space2]:32'b0;
    end
endmodule
