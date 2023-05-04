`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2023 09:20:56 PM
// Design Name: 
// Module Name: DECODER
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


module DECODER(
input [31:0] instruct,

output [4:0] rs1, rs2, rd,  //register output
//output [11:0] imm,
output [2:0] funct3,
output [6:0] op_out, funct7 //separate opcode/funct to control unit
    );
reg [2:0] funct3_o;
reg [6:0] opcode, funct7_o;
reg [4:0] rs1_o, rs2_o, rd_o;
//reg [11:0] immediate;

//assign imm = immediate;
assign op_out = opcode;
assign funct3 = funct3_o;
assign funct7 = funct7_o;

assign rs1 = rs1_o;
assign rs2 = rs2_o;
assign rd = rd_o;

always @(*) begin
    opcode = instruct[6:0];  //opcode is always last 7 bits of instructions
    funct3_o = instruct[14:12];
    funct7_o = instruct[31:25];
    
    rs1_o = instruct[19:15];  //register file inputs
    rs2_o = instruct[24:20];
    rd_o = instruct[11:7];

    /*case(opcode)    //send to sign extension
        7'b0010011: begin//I type instructions
            immediate = instruct[31:20];
            end 
        7'b1100011: begin //B type instructions
            immediate = {instruct[31], instruct[7], instruct[30:25], instruct[11:8], 1'b0};
            end
        7'b1101111: begin   //U type instructions
            immediate = {instruct[31:12], 12'b0};
            end
        7'b0100011: begin   // s type instructions
            immediate = {instruct[31:25], instruct[11:7]};
        end
        7'b1101111: begin
            immediate = {instruct[31], instruct[19:12], instruct[20], instruct[30:21], 1'b0};
        end
        default: begin
            immediate = 32'b0;
        end
        endcase*/
end
endmodule
