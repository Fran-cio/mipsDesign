`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.12.2022 18:42:11
// Design Name: 
// Module Name: mod_control_tb
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


module mod_control_tb;
    reg [6 - 1 : 0]           i_function;
    reg [6 - 1 : 0]           i_operation;
    reg                       i_enable_control;
    wire [18 - 1 : 0]          o_control;
    reg [31:0]                instruc;

   mod_control mod_control1(
        i_function,
        i_operation,
        i_enable_control,
        o_control
    );

    initial begin
        i_enable_control = 0;
        instruc = 32'b00000000000000000000000000000000; //SLL
        i_operation = instruc[31:26];
        i_function = instruc[5:0];
        #1
        instruc = 32'b10000000000000000000000000000000; //LB
        i_operation = instruc[31:26];
        i_function = instruc[5:0];

        #1
        instruc = 32'b10100000000000000000000000000000; //SB
        i_operation = instruc[31:26];
        i_function = instruc[5:0];

        #1
        instruc = 32'b00010000100001000000000000000000; //BEQ
        i_operation = instruc[31:26];
        i_function = instruc[5:0];
        #1
        instruc = 32'b00110100000000000000000000000000; //ORI
        i_operation = instruc[31:26];
        i_function = instruc[5:0];
        #1
        instruc = 32'b00000000000000000000000000001000;//JALR
        i_operation = instruc[31:26];
        i_function = instruc[5:0];
        #1
        instruc = 32'b00001100000000000000000000000000; //JAL
        i_operation = instruc[31:26];
        i_function = instruc[5:0];
        #1
        i_enable_control = 1;
        #1
        $finish;
    end
endmodule
