`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.12.2022 00:26:30
// Design Name: 
// Module Name: alu_control
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


module alu_control#(
    parameter TAM_ALU_OP  = 3,
    parameter TAM_FUNC = 6
)
(
    input   wire [TAM_ALU_OP  - 1 : 0]   i_alu_op,
    input   wire [TAM_FUNC - 1 : 0]   i_func,
    output  wire  [TAM_FUNC - 1 : 0]   o_alu_func
);

/* crt alu codes */
localparam EXE_ALUOP_ADD      = 3'b000;
localparam EXE_ALUOP_AND      = 3'b100;
localparam EXE_ALUOP_OR       = 3'b101;
localparam EXE_ALUOP_XOR      = 3'b110;
localparam EXE_ALUOP_SHIFTLUI = 3'b111;
localparam EXE_ALUOP_SLTI     = 3'b010;

/* ALU CODES */
localparam ADD      =   6'b110001;
localparam AND      =   6'b100100;
localparam OR       =   6'b100101;
localparam XOR      =   6'b100110;
localparam SHIFTLUI =   6'b101011;
localparam SLT      =   6'b101010;

reg[TAM_FUNC : 0] reg_alu_func; //tiene un bit extra para el carry

always @(*)
begin
    case (i_alu_op)
        EXE_ALUOP_ADD       :  reg_alu_func =   ADD;
        EXE_ALUOP_AND       :  reg_alu_func =   AND;
        EXE_ALUOP_OR        :  reg_alu_func =   OR;
        EXE_ALUOP_XOR       :  reg_alu_func =   XOR;
        EXE_ALUOP_SHIFTLUI  :  reg_alu_func =   SHIFTLUI;
        EXE_ALUOP_SLTI      :  reg_alu_func =   SLT;
        default             :  reg_alu_func =   i_func;
    endcase
end

assign o_alu_func = reg_alu_func;

endmodule

