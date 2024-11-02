`timescale 1ns / 1ps

module MemoryTB();
    
    reg [15:0] instruct_address;
    wire [31:0] instruct, read_data;
    wire [14:0] data_address;
    reg write_enable, tmp;

    wire [2:0] opcode;
    wire [4:0] add_r0, add_r1, add_r2;    
    
    reg [4:0] write_address_0;
    reg [31:0] tmp_data;
    wire [31:0] tmp_read, final_result;
    
    InstructionMemory InstructionMemory_UUT(.inst_address(instruct_address), .read_data(instruct));
    Decoder Decoder_UUT(.inst(instruct), .opcode(opcode), .reg_addr_0(add_r0), .reg_addr_1(add_r1), .reg_addr_2(add_r2), .addr(data_address));
    RegisterFile RegisterFile_UUT(.read_address_0(add_r0), .read_address_1(add_r1), .write_address_0(write_address_0), .write_en(tmp), .write_data(tmp_data), .read_data_0(read_data), .read_data_1(tmp_read));
    DataMemory DataMemory_UUT(.data_address(data_address), .write_en(write_enable), .write_data(read_data),.write_address_0(data_address) ,.read_data(final_result));
    
    initial begin
        
        instruct_address <= 7;
        write_enable <= 1;
        tmp <= 0;
        #10
        instruct_address <= 5;
        write_enable <= 0;
    
    end

endmodule
