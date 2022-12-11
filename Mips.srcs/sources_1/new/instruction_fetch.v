`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.12.2022 14:59:38
// Design Name: 
// Module Name: instruction_fetch
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

module instruction_fetch(
    input                   i_clk,
    input                   i_reset,
    input                   i_pc_reset,
    input                   i_stall,
    input   [32 - 1 : 0]    i_new_pc,
    input                   i_word_is_ready,
    input   [32 - 1 : 0]    i_word_sended, //la word que nos envía la suod a través del formador de palabras
    output  [32 - 1 : 0]    o_instruction,
    output                  o_is_end //cuando se termina de cargar la memoria de inst
);

pc_unit pc_unit(
    i_clk,
    i_reset,
    i_pc_reset,
    i_stall,
    i_new_pc,
    o_pc_value
);

memoria_de_instruccion mem_inst(
    i_clk,
    i_reset,
    i_word_is_ready,
    i_word_sended,
    o_pc_value, //La salida del PC entra a la mem
    o_instruction,
    o_is_end
);
endmodule