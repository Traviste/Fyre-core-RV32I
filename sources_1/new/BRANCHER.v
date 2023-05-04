`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2023 08:57:10 AM
// Design Name: 
// Module Name: BRANCHER
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


module BRANCHER(
    input [2:0] branch_op,  //6 branching instructions (funct3 pass from control unit)
    input [31:0] immediate, ALU_res, base,
    
    output write,
    output [31:0] new_addr
    );
    
    reg [31:0]  address;
    reg br_en;
    
    assign write = br_en;
    assign new_addr = address;
    
    
    always @(*) begin
    
        address = base + (immediate); //sets address to jump to
        case(branch_op) 
            3'b010: begin   //j instructions
                br_en = 1'b1;
            end
            3'b000: begin // BEQ
                br_en = (ALU_res == 0) ? 1'b1 : 1'b0;
            end
            3'b001: begin //BNE
                br_en = (ALU_res != 0) ? 1'b1: 1'b0;
            end
            3'b100: begin  //BLT
                br_en = (ALU_res == 1) ? 1'b1: 1'b0;
            end
            3'b101: begin  //BGE
                br_en = (ALU_res == 0) ? 1'b1: 1'b0;    //uses less than operation
            end
            3'b110: begin  //BLTU (unsigned)
                br_en = (ALU_res == 1) ? 1'b1: 1'b0;
            end
            3'b111: begin  //BGEU (subtract 2 registers)
                br_en = (ALU_res >= 0) ? 1'b1: 1'b0;
            end
            default:
                br_en = 1'b0;
        endcase
        
    end
    
endmodule
