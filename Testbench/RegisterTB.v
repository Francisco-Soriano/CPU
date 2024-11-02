`timescale 1ns / 1ps

module RegisterTB();
    
    reg [4:0] rd0, rd1, write;
    reg write_enable;
    reg [31:0] write_data;
    wire [31:0] read_data1, read_data2;
    
    RegisterFile RegisterFile_UUT(.read_address_0(rd0), .read_address_1(rd1), .write_address_0(write), .write_en(write_enable), .write_data(write_data), .read_data_0(read_data1), .read_data_1(read_data2));
    
    initial begin
        
        rd0 <= 9;
        rd1 <= 13;
        write_enable <= 0;
        #10
        write <= 3;
        write_data <= 175;
        write_enable <= 1;
        #10
        write <= 2;
        write_data <= 190;
        #10
        rd0 <= 3;
        rd1 <= 2;
        write_enable <= 0;
    
    end

endmodule
