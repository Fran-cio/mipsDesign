`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.12.2022 00:45:41
// Design Name: 
// Module Name: Alu_control_tb
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


module Alu_control_tb;
    wire [6 - 1 : 0]           i_function;
    wire [6 - 1 : 0]           i_operation;
    reg                       i_enable_control;
    wire[18 - 1 :  0]          o_control;
    reg [32 - 1 :   0]        instruc;
    wire [32 - 1 :   0]        i_data_a, i_data_b;

    wire  [6 - 1 : 0]   o_alu_func;
    
    wire [32 - 1 :   0] o_out;
    wire                o_zero_bit;


   mod_control mod_control1(
        i_function,
        i_operation,
        i_enable_control,
        o_control
    );
    alu_control aluControl(
        o_control[12:10],
        i_function,
        o_alu_func
    );
    alu Alu(
        i_data_a,
        i_data_b,
        o_alu_func,
        o_out,
        o_zero_bit
    );

assign i_operation = instruc[31:26];
assign i_function = instruc[5:0];
assign i_data_a = 32'd3;
assign i_data_b = 32'd2;

    initial begin
        i_enable_control = 0;     
          
        instruc = 32'b00000000011000100000000000100001; //ADDU
        // Esperado 5
        #1
        instruc = 32'b00000000011000100000000000100011; //SUBU
        // Esperado 1
        #1
        instruc = 32'b00000000011000100000000000100100; //AND
        // Esperado 2
        #1
        instruc = 32'b00000000011000100000000000100101; //OR
        // Esperado 3
        #1
        instruc = 32'b00100000000000000000000000001000;//ADDI
        #1
        // Esperado 5
        instruc = 32'b00110000000000000000000000001000; //ANDI
        // Esperado 2
        #1
        instruc = 32'b00110100011000100000000000100101; //ORI
        // Esperado 3   
        //i_enable_control = 1;
        #1
        $finish;
    end
endmodule
