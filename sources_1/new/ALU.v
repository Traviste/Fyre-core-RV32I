`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2023 11:27:17 AM
// Design Name: 
// Module Name: ALU
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

module ALU(
input [3:0] ALU_op,
input [31:0] val1, val2,
output[31:0] ALU_res
//,output zero
    );
    
    reg [31:0] result;
    assign ALU_res = result;
    always @(*) begin
    case(ALU_op)
        4'b0001:
            result = val1 & val2;  //AND
        4'b0010:
            result = val1 | val2;  //OR
        4'b0011:
            result = val1 ^ val2;  //XOR
        4'b0100:
            result = val1 + val2;  //ADD
        4'b0101:
            result = val1 - val2;   //SUB
        4'b0110:
            result = val1 << val2; //SLL
        4'b0111:
            result = val1 >> val2; //SRL
        4'b1000:
            result = val1 < val2; //LTU
        4'b1001:
            result = $signed(val1) < $signed(val2); //LT
        4'b1010:    //SRA
            result = $signed(val1) >>> val2[4:0];
        default:
            result = 32'd0;
            
        endcase
    end
    
endmodule
