`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2023 04:28:17 PM
// Design Name: 
// Module Name: EXT_tb
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


module EXT_tb(

    );
    
    reg [2:0] imm_type;
    reg [31:0] instruct;
    wire [31:0] imm_out;
    SIGN_EXT UUT(.imm_type(imm_type), .instruct(instruct), .imm_out(imm_out));
    
    initial begin
    instruct = 32'h7FFFFFFF;
    #10;
    
    imm_type = 3'b001;
    #10;
    
    imm_type = 3'b010;
    #10;
    
    imm_type = 3'b011;
    #10;
    
    imm_type = 3'b100;
    #10;
    
    imm_type = 3'b111;
    #10;
    end
endmodule
