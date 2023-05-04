`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2023 06:13:40 PM
// Design Name: 
// Module Name: mux_BRANCH
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


module mux_BRANCH(
input base_sel,
input [31:0] PC, rs1,

output [31:0] base
    );
    //JAL jumps from PC address, and JALR jumps from rs1
    
    reg [31:0] brancher;
    assign base = brancher;
    always @(*) begin
        brancher = (base_sel == 1) ? PC: rs1;
    end
endmodule
