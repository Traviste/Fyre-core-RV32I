`timescale 1ns / 1ps
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2023 12:11:44 PM
// Design Name: 
// Module Name: CONTROL

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CONTROL(
input [6:0] opcode, funct7,
input [2:0] funct3,

output W_EN,    //REG_FILE control
output [1:0] rd_sel,

output [2:0] imm_type,   //Immediate (sign_ext) control

output imm_sel, sel2, //ALU control
output [3:0] ALU_op, 

output write_op, read_op, data_extend, //DATA_MEM control
output [2:0] mem_width,

//Brancher Control
output[2:0] jump_ctrl,  //branching instructions
output branch_base  //1 for PC and 0 for rs1

    );
    reg alu_src, alu_src2, regWrite;
    reg mem_o, mem_in, mem_ext;
    reg [2:0] width;
    reg [4:0] operation;
    reg [2:0] itype_o;
    reg [1:0] muxrd_o;
    reg muxbase_o;
    reg [2:0] jumper_o;
    
    assign imm_sel = alu_src;   //ALU control (imm(1) or rs2(0))
    assign sel2 = alu_src2;     //rs1(1) or PC (0)
    assign ALU_op = operation;
    
    assign imm_type = itype_o;  //sign_ext (immediate manipulation)
    
    assign W_EN = regWrite;     //register file control
    assign rd_sel = muxrd_o;    //writeback to reg file
    
    assign jump_ctrl = jumper_o;    //brancher control
    assign branch_base = muxbase_o; //define base
    
    assign write_op = mem_in;  //data memory control
    assign read_op = mem_o;
    assign data_ext = mem_ext;
    assign mem_width = width;
    
    always @(*) begin
        case(opcode)
            7'b0110111: begin //LUI
                itype_o = 3'b011;   //u-type
                muxrd_o = 2'b01;    //immediate input
                regWrite = 1'b1;
                end
                
            7'b0010111:begin //AUIPC
                itype_o = 3'b011;   //u-type
                alu_src = 1'b1;     //immediate
                alu_src2 = 1'b0;    //PC address
                operation = 4'b0100;//ALU add: PC and immediate
                
                muxrd_o = 2'b10;    //ALU_res writeback
                regWrite = 1'b1;
                end
                
            7'b1101111:begin        //JAL
                muxrd_o = 2'b00;    //saves PC+4 to rd
                regWrite = 1'b1;
                
                itype_o = 3'b001;
                muxbase_o = 1'b1;   //address = PC + offset
                jumper_o = 3'b010;  //brancher jump (unconditional)
                end
                
            7'b1100111:begin //JALR type instructions
                muxrd_o = 2'b00;
                regWrite = 1'b1;
                
                itype_o = 3'b001;
                muxbase_o = 1'b0;   //address = rs1 + offset
                jumper_o = 3'b010;
                end
                
            7'b1100011:begin //B type instructions (base mux PC/rs1??)
                itype_o = 3'b010;   //B type immediate
                jumper_o = funct3;
                alu_src = 1'b0;     //rs2
                alu_src2 = 1'b1;    //rs1
                case(funct3)
                    3'b000:begin    //beq
                        operation = 4'b0101;     //subtraction
                    end
                    3'b001:begin    //bne
                        operation = 4'b0101;    //Subtraction
                    end
                    3'b100:begin    //blt
                        operation = 4'b1000;    //LT
                    end
                    3'b101:begin    //bge
                        operation = 4'b1000;    //LT
                    end
                    3'b110:begin    //bltu
                        operation = 4'b1001;    //LTU
                    end
                    3'b111:begin    //bgeu
                        operation = 4'b0101;    //subtraction
                    end
                    endcase
                end
            7'b0000011:begin    //Load type instructions (must include sign_ext!!)
                itype_o = 3'b001;   //i type instruction
                alu_src = 1'b1;     //select immediate
                alu_src2 = 1'b1;    //select rs1
                operation = 4'b0100;//rs1 + operation
                mem_o = 1'b1;       //read enable
                case(funct3)
                    3'b000:begin    //lb
                        width = 2'b10;
                        mem_ext = 1'b1; //signed byte
                    end
                    3'b001:begin    //lh
                        width = 2'b01;
                        mem_ext = 1'b1;
                    end
                    3'b010:begin    //lw
                        width = 2'b00;
                    end
                    3'b100:begin    //lbu
                        width = 2'b10;
                        mem_ext = 1'b0; //unsigned
                    end
                    3'b101:begin    //lhu
                        width = 2'b01;
                        mem_ext = 1'b0;
                    end
                    endcase
                    muxrd_o = 2'b11;    //mux select data mem
                    regWrite = 1'b1;
                end
                
            7'b0100011:begin //Store type instructions
                itype_o = 3'b101;   //s type immediate
                alu_src = 1'b1;     //select immediate
                alu_src2 = 1'b1;    //select rs1
                operation = 4'b0100;//rs1 + operation
                mem_in = 1'b1;      //W_EN high
                case(funct3)
                    3'b000: //sb
                        width = 2'b10;
                    3'b001: //sh
                        width = 2'b01;
                    3'b010: //sw
                        width = 2'b00;
                endcase
                end
            7'b0010011:begin //immediate instructions
                case(funct3)
                    3'b000: begin
                        itype_o = 3'b001;   //i type immediate
                        alu_src = 1'b1;     //select immediate
                        alu_src2 = 1'b1;    //select rs1

                        operation = 4'b0100;    //addi
                        end
                    3'b010:begin
                        itype_o = 3'b001;   //i type immediate
                        alu_src = 1'b1;     //select immediate
                        alu_src2 = 1'b1;    //select rs1

                        operation = 4'b1001;    //slti
                        end
                    3'b011:begin
                        itype_o = 3'b001;   //i type immediate
                        alu_src = 1'b1;     //select immediate
                        alu_src2 = 1'b1;    //select rs1

                        operation = 4'b1000;    //sltiu
                        end
                    3'b100:begin
                        itype_o = 3'b001;   //i type immediate
                        alu_src = 1'b1;     //select immediate
                        alu_src2 = 1'b1;    //select rs1

                        operation = 4'b0011;    //XORI
                        end
                    3'b110:begin
                        itype_o = 3'b001;   //i type immediate
                        alu_src = 1'b1;     //select immediate
                        alu_src2 = 1'b1;    //select rs1
                        
                        operation = 4'b0010;    //ORI
                        end
                    3'b111:begin
                        itype_o = 3'b001;   //i type immediate
                        alu_src = 1'b1;     //select immediate
                        alu_src2 = 1'b1;    //select rs1

                        operation = 4'b0001;    //ANDI
                        end
                    3'b001:begin     //SLLI (immediate type FIXME!!)
                        itype_o = 3'b001;
                        alu_src = 1'b1;     //select immediate
                        alu_src2 = 1'b1;    //select rs1
                        operation = 4'b0110;
                        
                        end
                    3'b101: begin
                        itype_o = 3'b001;
                        alu_src = 1'b1;     //select immediate
                        alu_src2 = 1'b1;    //select rs1
                        
                        if(funct7 == 7'b0000000)begin   //SRLI
                            operation = 4'b0111;
                            end
                        if(funct7 == 7'b0100000)begin   //SRAI
                            operation = 4'b1010;
                            end 
                        end
                endcase
                muxrd_o = 2'b10;    //ALU_res writeback
                regWrite = 1'b1;
                end
                
            7'b0110011:begin //REG type instructions
                alu_src = 1'b0;     //select rs2
                alu_src2 = 1'b1;    //select rs1
                if(funct7 == 7'b0000000) begin
                    case(funct3)
                        3'b000:     //ADD
                            operation = 4'b0100;
                        3'b001:     //SLL
                            operation = 4'b0110;
                        3'b010:     //SLT
                            operation = 4'b1001;
                        3'b011:     //SLTU
                            operation = 4'b1000;
                        3'b100:     //XOR
                            operation = 4'b0011;
                        3'b101:     //SRL
                            operation = 4'b0111;
                        3'b110:     //or
                            operation = 4'b0010;
                        3'b111:     //and
                            operation = 4'b0001;
                    endcase
                    end
                else if(funct7 == 7'b0100000) begin
                    case(funct3)
                        3'b000:     //SUB
                            operation = 4'b0101;
                        3'b101:     //SRA
                            operation = 4'b1010;
                    endcase
                    end
                muxrd_o = 2'b10;    //ALU_res writeback
                regWrite = 1'b1;
                end
            7'b0001111:begin //FENCE
                end
            7'b1110011:begin //ECALL/EBREAK
                end
        endcase
    end
endmodule
