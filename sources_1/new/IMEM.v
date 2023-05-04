`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2023 09:03:20 PM
// Design Name: 
// Module Name: IMEM
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


module IMEM(
input CLK, RST,
input [31:0] addr,
output [31:0] instruct
    );
    reg [31:0] memory [0:1023];
    reg [31:0] next;
    assign instruct = next;
    
    initial begin
     $readmemh("intr_flash.mem", memory);
    end
    
    always @(posedge CLK) begin
        if(RST) begin
            next <= 32'b0;
        end
        else begin
            next <= memory[addr[14:0]/4];
        end
    end
    
endmodule
