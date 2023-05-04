`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2023 09:14:18 PM
// Design Name: 
// Module Name: REG_tb
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


module REG_tb(
);
reg CLK, RST, W_EN;  //control signals
reg [3:0] address, space1, space2;   //address bus
reg [15:0] INIT;    //input reg value
wire [15:0] REG1, REG2; //output
    REG_FILE UUT(.CLK(CLK), .RST(RST), .W_EN(W_EN), 
    .address(address), .space1(space1), .space2(space2),
    .INIT(INIT),
    .REG1(REG1), .REG2(REG2));
    
    initial begin
    RST = 1'b1;
    #30;
    RST = 1'b0;
    INIT = 32'h0009;
    #20;
    W_EN = 1'b1;
    address = 32'h005C;
    space1 = 32'h005C;
    space2 = 32'h00FF;
    #20;
    W_EN = 1'b0;
    INIT = 32'h0304;
    address = 32'h00FF;
    #20;
    W_EN = 1'b1;
    end
    
    always begin
    CLK = 1'b1;
    #10;
    CLK = 1'b0;
    #10;
    end
    
endmodule
