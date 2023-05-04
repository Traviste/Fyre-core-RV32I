`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2023 04:38:42 PM
// Design Name: 
// Module Name: mux_REG1
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


module mux_REG1(
input[31:0] PC_addr,
input[31:0] RS1,
input ctrl_RS1,

output [31:0] alu_in
    );
    
    reg [31:0] mux_o;
    assign alu_in = mux_o;
    always @(*) begin
        mux_o = (ctrl_RS1==0) ? PC_addr : RS1;
    end
endmodule
