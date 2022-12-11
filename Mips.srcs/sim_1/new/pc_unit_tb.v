`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2022 11:05:47
// Design Name: 
// Module Name: pc_unit_tb
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
module pc_unit_tb;
    //Inputs
    reg                     i_clk;
    reg                     i_pc_reset;
    reg     [32 - 1 : 0]    i_new_pc;
    //Outputs
    wire    [32 - 1 : 0]    o_pc_value;

    pc_unit pc_unit1(
        i_clk,
        i_pc_reset,
        i_new_pc,
        o_pc_value
    );

    initial begin
        i_clk = 0;
        i_pc_reset = 0;
        i_new_pc = 32'hA4A3A2A1;
        #50
        i_pc_reset = 1;
        #10
        i_pc_reset = 0;
        i_new_pc = 32'hFFFF0FFF;
        #50
        i_pc_reset = 1;
        #10
        i_pc_reset = 0;
    end

    always begin
        #1
        i_clk = ~i_clk;
    end  
endmodule