`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2023 10:30:34 AM
// Design Name: 
// Module Name: MEM_tb
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


module MEM_tb(

    );
    
    reg CLK, data_i, data_o, signext;
    reg[1:0] data_width;
    reg [31:0] data_addr, input_data;
    wire[31:0] read;
    DATA_MEM UUT(.CLK(CLK), .data_width(data_width), .data_i(data_i), .data_o(data_o),.data_addr(data_addr), .signext(signext), .input_data(input_data), .read(read));

    always begin
        CLK = 1'b1;
        #10;
        CLK = 1'b0;
        #10;
    end
    
    initial begin
    data_addr = 32'd5;
    input_data = 32'd2;
    signext = 1'b0;
    #20;
    
    data_o = 1'b0;
    data_i = 1'b1;
    data_width = 2'b00;
    
    #20;
    data_o = 1'b1;
    data_i = 1'b0;
    data_width = 2'b00;
    
    #30;
    /*data_width = 2'b01;
    
    #20;
    data_width = 2'b10;
    
    #20;
    signext = 1'b0;
    data_width = 2'b00;
    
    #20;
    data_width = 2'b01;
    
    #20;
    data_width = 2'b10;
    
    #20;*/
    $finish;
    end
endmodule
