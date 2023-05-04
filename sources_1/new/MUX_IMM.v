`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2023 03:33:28 PM
// Design Name: 
// Module Name: MUX_IMM
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


module MUX_IMM(
input ctrl,
input [31:0] immediate, rVal,
output [31:0] opVal
    );
    reg [31:0] sel;
    assign opVal = sel;
    
    always @(*) begin
        sel = (ctrl == 1) ? immediate: rVal; //if 1 then allow immediate instructions, else pass register value
    end
endmodule
