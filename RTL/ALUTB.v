`timescale 1ns / 1ps

module ALUTB();
    
    reg [31:0] operand1, operand2;
    reg [2:0] opcode;
    wire [31:0] oOutput;
    wire newPC;
    
    ALU ALU_UUT(.ip_0(operand1), .ip_1(operand2), .opcode(opcode), .op_0(oOutput), .change_pc(newPC));
    
    initial begin
        
        operand1 <= 102;
        operand2 <= 93;
        opcode <= 4;
        #10
        operand1 <= 91;
        operand2 <= 2;
        opcode <= 5;
        #10
        operand1 <= 32;
        operand2 <= 20;
        opcode <= 6;
        #10
        operand1 <= 10;
        operand2 <= 23;
        opcode <= 7;
        #10
        operand1 <= 2;
        operand2 <= 2;
        opcode <= 2;
        #10
        operand1 <= 8;
        #10
        operand1 <= 61;
        operand2 <= 65;
        opcode <= 3;
        #10
        operand1 <= 524;
    
    end
endmodule
