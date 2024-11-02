`timescale 1ns / 1ps
/*
Instruction Module

A 2-d register array with one read port
*/


module  InstructionMemory(
    input [15:0] inst_address,
    output [31:0] read_data
    );
    
    reg [31:0] ram [255:0];
    
    // Initialize Instructions in the memory for testing
    initial begin
        ram[0] <= 32'b0010_0000_0000_0000_0000_0000_0000_0100; // Store instruction that reads registerFile[0] and write to dataMemory[4].
        ram[1] <= 32'b0000_0000_0000_0000_0000_0000_0000_0010; // LW Instruction RegFile[0] = 2
        ram[2] <= 32'b1000_0000_0000_0000_0100_0000_0000_0000; // Add Instruction Reg[1] = Reg[0] + Reg[0] so Reg[1] = 4
        ram[3] <= 32'b0100_0001_0000_1000_0000_0000_0000_0101; // BEQ Instruction Reg[1] == Reg[1] and Branches to instruction 5
        ram[4] <= 32'b1100_0011_0000_1001_0000_0000_0000_0000; // AND Instruction Reg [3] & Reg[1] into Reg[4] so Reg[4] = 4 AND 5 = 4
        ram[5] <= 32'b0100_0001_0010_0000_0000_0000_0000_1011; // BEQ Instruction Reg[1] == Reg[4] and Branches to instruction 11
        ram[6] <= 32'b1010_0001_0000_0000_1000_0000_0000_0000; // Sub Instruction Reg[1] - Reg[0] so put result in Reg[2] so Reg[2] should be 2
        ram[7] <= 32'b1110_0010_0000_1000_1100_0000_0000_0000; // OR Instruction Reg[2] | Reg[1] into Reg[3] so Reg[3] = 2 OR 4 = 6
        ram[8] <= 32'b0110_0001_0001_1000_0000_0000_0000_0100; // BLT Instruction Reg [1] < Reg[3] so 4 < 6, branches to instruction 4
        ram[9] <= 32'b0010_0011_0000_0000_0000_0000_0000_0000; // Store Instruction stores Reg[3] into dataMemory[0] so dataMemory[0] should be 6
        ram[10] <= 32'b0000_0000_0000_0000_0000_0000_0000_0000; // Branch to address 0 (end of program)
    end
    
    // Assign statement to read ram based on inst_address
    assign read_data = ram[inst_address];

endmodule
