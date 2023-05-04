`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 10:27:49 AM
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb();

reg [3:0] ALU_op;
reg [32:0] val1, val2;
wire [32:0] ALU_res;

ALU UUT(.ALU_op(ALU_op), .val1(val1), .val2(val2), .ALU_res(ALU_res));

initial begin
    val1 = 8'b11111111111;
    val2 = 8'b10101010101;
    ALU_op = 4'b0000;
    #10;
    ALU_op = 4'b0001;
    #10;
    ALU_op = 4'b0010;
    #10;
    ALU_op = 4'b0011;
    #10;
    ALU_op = 4'b0100;
    #10;
    ALU_op = 4'b0101;
    #10;
    ALU_op = 4'b0110;
    #10;
    ALU_op = 4'b0111;
    #10;
    ALU_op = 4'b1000;
    #10
    $finish;
    end
endmodule
