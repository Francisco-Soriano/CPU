`timescale 1ns / 1ps

module CPUTB();
    
    reg clk;
    CPU UUT(.clk(clk));
    
    initial begin
        clk = 0;
    end
    
    always #10 clk = ~clk;

endmodule