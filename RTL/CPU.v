`timescale 1ns / 1ps

/*
CPU Module

Top Module for CPU.

*/


module CPU(
    input clk
    );
    
    reg [15:0]  pc_q = 0;      // Program Counter
    reg [31:0]  instruction_q; // Holds instruction binary 
    reg [1:0]   state_q = 0;   // State of CPU
    
    wire [2:0] opcode_wire;
    wire [4:0] reg_a, reg_b, reg_c;
    wire [14:0] address_wire;
    reg [31:0] data_write, instruction_reg, write_data_reg, operand1, operand2;
    wire [31:0] data_read, data_read2, read_data_reg1, read_data_reg2, ALU_result;
    reg write_enable, write_enable_data;
    wire pc_change;
    reg [2:0] opcode_clone_reg;
    reg [14:0] write_address;
    
    InstructionMemory IM(.inst_address(pc_q), .read_data(data_read));
    Decoder DEC_instance1(.inst(instruction_reg), .opcode(opcode_wire), .reg_addr_0(reg_a), .reg_addr_1(reg_b), .reg_addr_2(reg_c), .addr(address_wire));
    RegisterFile RF_instance1(.read_address_0(reg_a), .read_address_1(reg_b), .write_address_0(reg_c), .write_en(write_enable), .write_data(write_data_reg), .read_data_0(read_data_reg1), .read_data_1(read_data_reg2));
    ALU ALU_instance1(.ip_0(operand1), .ip_1(operand2), .opcode(opcode_clone_reg), .op_0(ALU_result), .change_pc(pc_change));
    DataMemory DM_instance1(.data_address(address_wire), .write_en(write_enable_data), .write_data(data_write), .write_address_0(write_address),.read_data(data_read2));
    
    always@(posedge clk)
    begin
        if(state_q == 0) begin // Fetch Stage
            write_enable <= 0;
            write_enable_data <= 0;
            // Read instruction from instruction memory
            instruction_q <= data_read;
            // increment PC
            pc_q <= pc_q + 1;
            // increment state
            state_q <= 1;
        end else if(state_q == 1) begin  // Decode Stage       
            // Instruction Decode and read data from register/memory
            instruction_reg <= instruction_q;
            // store all data necessary for next stages in a register 
            // This is done by instruct <= instruction_q as all the data ready to be sent for ALU ops
            state_q <= 2;  //update state
        end else if(state_q == 2) begin  // Execute Stage       
            // Perform ALU operations
            if(opcode_wire > 1) begin
                operand1 <= read_data_reg1;
                operand2 <= read_data_reg2;
                opcode_clone_reg <= opcode_wire;
            end
            else begin
                opcode_clone_reg <= opcode_wire;
                operand1 <= 0;
                operand2 <= 0;
                write_enable <= 0;              
            end
            state_q <= 3; //update state
        end else if(state_q == 3) begin  // Memory Stage
            // Access Memory and register file(for load)
            write_enable <= 0;
            if(opcode_wire < 2) begin
                if(opcode_wire == 1) begin
                    write_enable_data <= 1;
                    data_write <= read_data_reg1;
                    write_address <= address_wire;
                end
                else if(opcode_wire == 0) begin
                    write_data_reg <= data_read2;
                    write_enable <= 1;
                end
            end
            if(opcode_wire > 3) begin
                write_enable <= 1;
                write_data_reg <= ALU_result;
            end
            if(opcode_wire < 4) begin
                pc_q <= (pc_change == 1) ? address_wire : pc_q;
            end
            state_q <= 0;
        end    
    end
    
endmodule
