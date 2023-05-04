`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2023 11:27:10 AM
// Design Name: 
// Module Name: DATA_MEM
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


module DATA_MEM(
input CLK, 
input [1:0] data_width, //0 for word, 01 for half word, 2 for byte
input [31:0] data_addr, //32 bit input, but still 15 address bits

input data_i, 
input [31:0] input_data,    //rs2

input data_o, signext,
output [31:0] read
    );
    reg [7:0] memory [0:4020];  //128x8 memory, 15 address bits
    
    reg [31:0] read_out;
    assign read = read_out;
    
    always @(posedge CLK) begin
    if(data_i) begin  //store
        case(data_width)
        2'b00:  //word
            {memory[data_addr +3], memory[data_addr+2], memory[data_addr +1], memory[data_addr]} <= input_data;
        2'b01:  //short
            {memory[data_addr +1], memory[data_addr]} <= input_data;
        2'b10:  //byte
            memory[data_addr] <= input_data;
        default://word default
            {memory[data_addr +3], memory[data_addr+2], memory[data_addr +1], memory[data_addr]} <= input_data;
        endcase
    end
    else if(data_o) begin //load
        case(data_width)
        2'b00:  //word
            read_out <= {memory[(data_addr +3)], memory[(data_addr+2)], memory[(data_addr +1)], memory[data_addr]};
        2'b01:  //half word (signed or unsigned)
            read_out <= signext ? {{16{memory[data_addr+1][7]}}, memory[data_addr +1], memory[data_addr]} : {16'b0, memory[data_addr+1], memory[data_addr]};
        2'b10:  //byte (signed or unsigned)
            read_out <= signext ? {{24 {memory[data_addr][7]}}, memory[data_addr]} : {24'b0, memory[data_addr][7:0]};
        default:
            read_out <= {memory[data_addr +3], memory[data_addr+2], memory[data_addr +1], memory[data_addr]};
        endcase
    end
    
    end
endmodule
