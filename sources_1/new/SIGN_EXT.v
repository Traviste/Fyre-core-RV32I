`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2023 11:28:30 AM
// Design Name: 
// Module Name: SIGN_EXT
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


module SIGN_EXT(
input [2:0] imm_type,
input [31:0] instruct,
output [31:0] imm_out
    );
    
    reg [31:0] extend;
    assign imm_out = extend;
    
    always @(*)begin
    case(imm_type)
        3'b000:begin //invalid instructions
            extend = 32'b0;
            end
        3'b001: begin//I type instructions
            extend = {{20{instruct[31]}},instruct[31:20]};
            end 
        3'b010: begin //B type instructions
            extend = {{20{instruct[31]}}, instruct[7], instruct[31:25], instruct[11:8], 1'b0};
            end
        3'b011: begin   //U type instructions
            extend = {instruct[31:12], 12'b0};
            end
        3'b100: begin   //jump instruction
            extend = {{12{instruct[31]}}, instruct[19:12], instruct[20], instruct[30:21], 1'b0};
        end
        3'b101: begin   //store instructions
            extend = {{20{instruct[31]}}, instruct[31:25], instruct[11:7]};
        end
        default: begin
            extend = 32'bx;
        end
    endcase
    end
endmodule
