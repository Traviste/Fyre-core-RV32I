`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2023 04:03:10 PM
// Design Name: 
// Module Name: TOP_PROCESSOR
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


module TOP_PROCESSOR(   //only tests the register file/immediate mux/and ALU
input CLK, RST, //all modules

//input [2:0] imm_type,   //sign_ext

//input [31:0] address, write,

//input alu_src, alu_src2,

input alu_ck,   //temporary to test ALU (remove later)
//input [3:0] operation,  //ALU operation

//input [1:0] data_width,
//input mem_i, mem_o, signext,

//input base_sel, //branch test
//input [2:0] branch_op,

/*output [6:0] funct7, op_out,    //decoder (extra) output
output [2:0] funct3,*/

//output b_en,
output [31:0] ALU_res
    );
    /*addi x3, x0, 5
addi x2, x0, 3
sub x1, x3, x2
beq x1, x2, Exit
sw x1, 0(x3)
Exit:
lw x4, 0(x3)*/
    wire [31:0] instruct, out;
    wire [31:0] REG1, REG2;
    wire [31:0] val1, val2;
    wire [31:0] next;
    wire [31:0] imm_out;
    wire [4:0] rs1, rs2, rd;
    wire [31:0] rd_in;
    wire [31:0] res;
    wire [31:0] base;
    wire [31:0] new, read;
    wire b_en, W_EN, alu_src, alu_src2, mem_i, mem_o, signext, base_sel;
    wire [1:0] rd_sel;
    wire [2:0] data_width, funct3, imm_type, branch_op;
    wire [3:0] operation;
    wire [6:0] op_out, funct7;
    
    CONTROL ctrl_test(.opcode(op_out), .funct7(funct7),.funct3(funct3),
                      .W_EN(W_EN), .rd_sel(rd_sel),
                      .imm_type(imm_type),
                      .imm_sel(alu_src), .sel2(alu_src2),
                      .ALU_op(operation),
                      .write_op(mem_o), .read_op(mem_i), .data_extend(signext), .mem_width(data_width),
                      .branch_base(base_sel), .jump_ctrl(branch_op));
                      
    P_COUNTER test0(.CLK(CLK), .RST(RST), .write(b_en), .addr(new), .out(out), .next(next));
    IMEM test1(.CLK(CLK), .RST(RST), .addr(out), .instruct(instruct));
    DECODER test2(.instruct(instruct), .rs1(rs1), .rs2(rs2), .rd(rd), .op_out(op_out), .funct3(funct3), .funct7(funct7));
    SIGN_EXT test3(.imm_type(imm_type), .instruct(instruct), .imm_out(imm_out));
    
    REG_FILE unit4(.CLK(CLK), .RST(RST), .W_EN(W_EN),
                   .address(rd), .space1(rs1), .space2(rs2), .INIT(rd_in),    //init temporary wire!!
                   .REG1(REG1), .REG2(REG2));
                   
    MUX_IMM test5 (.ctrl(alu_src), .immediate(imm_out), .rVal(REG2), .opVal(val2));
    mux_REG1 test6 (.ctrl_RS1(alu_src2), .RS1(REG1), .PC_addr(next), .alu_in(val1));
    
    ALU test7(.ALU_op(operation), .val1(val1), .val2(val2), .ALU_res(res));
    mux_RD test8( .PC_next(next), .immediate(imm_out), .ALU_res(res), .mem_read(read), .rd_sel(rd_sel), .rd_data(rd_in) );   //FIXME mem_read!!;
    
    MUX_IMM check(.ctrl(alu_ck), .immediate(res), .rVal(out), .opVal(ALU_res));
    mux_BRANCH test9(.base_sel(base_sel), .PC(out), .rs1(REG1), .base(base));
    BRANCHER test10(.branch_op(branch_op), .immediate(imm_out), .ALU_res(res), .base(base), .write(b_en), .new_addr(new));
    DATA_MEM test11(.CLK(CLK), .data_width(data_width), .data_addr(res), .data_i(mem_i), .input_data(REG2), .data_o(mem_o), .signext(signext), .read(read));
    
endmodule
