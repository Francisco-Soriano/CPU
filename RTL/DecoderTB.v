`timescale 1ns / 1ps

module DecoderTB();

    reg [31:0] instruct;
    wire [2:0] opcode;
    wire [4:0] r0, r1, r2;
    wire [14:0] dec_address;
    
    Decoder Decoder_UUT(.inst(instruct), .opcode(opcode), .reg_addr_0(r0), .reg_addr_1(r1), .reg_addr_2(r2), .addr(dec_address));
    
    initial begin
        
        instruct <= 32'he208_c000;
        #30 
        instruct <= 32'h6118_0004;
        #30
        instruct <= 32'h2300_0000;
    
    end
    
endmodule