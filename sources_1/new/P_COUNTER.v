`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2023 03:37:30 PM
// Design Name: 
// Module Name: P_COUNTER
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


module P_COUNTER(
input CLK, RST, write,
input [31:0] addr,
output [31:0] out, next
    );
    
    reg [31:0] PC;
    assign out = PC;
    assign next = PC+4;
    
    always @(posedge CLK) begin
        if(RST) begin
            PC <= 32'b0;
            end
        else if(write) begin
            PC <= addr;
            end
        else begin
            PC <= PC + 32'h4;  //increment counter by 4
            end
    end
    
endmodule
