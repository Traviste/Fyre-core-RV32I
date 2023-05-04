`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2023 07:22:41 PM
// Design Name: 
// Module Name: mux_RD
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


module mux_RD(
input [31:0] PC_next,   //JALR
input [31:0] immediate,
input [31:0] ALU_res,   //R-type instructions
input [31:0] mem_read,  //load instructions

input [1:0] rd_sel,
output [31:0] rd_data
    );
    
    reg [31:0] in_rd;
    assign rd_data = in_rd;
    
    always @(*) begin
        case (rd_sel)
            2'b00:
                in_rd = PC_next;
            2'b01:
                in_rd = immediate;
            2'b10:
                in_rd = ALU_res;
            2'b11:
                in_rd = mem_read;
         endcase
    end
endmodule
