`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2023 09:02:34 AM
// Design Name: 
// Module Name: CORE_tb
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


module CORE_tb(

    );
    reg CLK, RST;
    reg alu_ck;//, write;
    //reg [3:0] ALU_op;
    //reg [31:0] address;
    /*reg [2:0] imm_type;
    reg [2:0] branch_op;
    reg [3:0] operation;
    reg W_EN, alu_src, alu_src2;   //regfile writeback
    reg [1:0] rd_sel;
    reg alu_ck; //temporary
    reg base_sel;
    //wire b_en;
    reg [1:0] data_width;
    reg signext, mem_o, mem_i;
    wire [6:0] funct7, op_out;
    wire [2:0] funct3;*/
    wire [31:0] res;//, read;
    //wire [31:0] read;
    
    TOP_PROCESSOR UUT(.CLK(CLK), .RST(RST),// .write(write),
                      .alu_ck(alu_ck),
                      /*.imm_type(imm_type),// .address(address),
                      .W_EN(W_EN), .rd_sel(rd_sel), .alu_src(alu_src), .alu_src2(alu_src2),
                      .alu_ck(alu_ck),.operation(operation),
                      .base_sel(base_sel), .branch_op(branch_op),
                      .data_width(data_width),
                      .mem_i(mem_i),.mem_o(mem_o), .signext(signext),
                      //.b_en(b_en),
                      .funct3(funct3), .funct7(funct7), .op_out(op_out),*/
                      .ALU_res(res));
    always begin
    CLK = 1'b1;
    #2;
    CLK = 1'b0;
    #2;
    end

    initial begin
    RST = 1'b1;
    //address = 32'b0;
    //write = 1'b0;
    /*imm_type = 3'b000;
    W_EN = 1'b0;
    operation = 4'b0000;
    #2*/
    alu_ck = 1'b1;
    #2
    RST = 1'b0;
    #2
    
    /*imm_type = 3'b001;
    alu_src = 1'b1;     //select immediate
    alu_src2 = 1'b1;    //select RS1
    operation = 4'b0100;
    W_EN = 1'b1;
    rd_sel = 2'b10;
    alu_ck = 1'b1;
    #4
    
    imm_type = 3'b001;
    alu_src = 1'b1;
    alu_src2 = 1'b1;
    operation = 4'b0100;
    W_EN = 1'b1;
    rd_sel = 2'b10;
    alu_ck = 1'b1;
    #4
    
    imm_type = 3'b000;
    alu_src = 1'b0;
    alu_src2 = 1'b1;
    operation = 4'b0101;
    W_EN = 1'b1;
    rd_sel = 2'b10;
    alu_ck = 1'b1;
    
    #4
    imm_type = 3'b010;
    alu_src = 1'b0;
    alu_src2 = 1'b1;
    operation = 4'b0101;
    base_sel = 1'b1;    //select PC
    branch_op = 3'b000;
    alu_ck = 1'b1;
    
    #4
    W_EN = 1'b0;
    imm_type = 3'b101;
    alu_src = 1'b1;
    alu_src2 = 1'b1;
    operation = 4'b0100;
    mem_i = 1'b1;
    mem_o = 1'b0;
    data_width = 2'b00;
    signext = 1'b0;
    //alu_ck = 1'b0;
    
    #4
    imm_type = 3'b001;
    alu_src = 1'b1;
    alu_src2 = 1'b1;
    operation = 4'b0100;
    mem_i = 1'b0;
    mem_o = 1'b1;
    data_width = 2'b00;
    signext = 1'b0;
    rd_sel = 2'b11;
    W_EN = 1'b1;
    //alu_ck = 1'b1;
   /*
    W_EN = 1'b0;
    imm_type = 3'b101;
    alu_src = 1'b1;
    alu_src2 = 1'b1;
    operation = 4'b0100;
    data_r = 1'b0;
    data_w = 1'b1;
    data_width = 2'b00;
    
    #4
    imm_type = 3'b001;
    alu_src = 1'b1;
    alu_src = 1'b1;
    operation = 4'b0100;
    data_w = 1'b0;
    data_r = 1'b1;
    data_width = 2'b00;*/
    #40

    $finish;
    
    end
    
endmodule
