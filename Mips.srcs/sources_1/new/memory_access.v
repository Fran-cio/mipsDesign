`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.12.2022 14:59:38
// Design Name: 
// Module Name: memory_access
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

module memory_access(
    input                   i_clk,
    input                   i_reset,
    input                   i_wr_mem,
    input                   i_is_unsigned,
    input   [2 - 1 :  0]    i_data_mask, 
    input   [32 - 1 : 0]    i_direc_mem,
    input   [32 - 1 : 0]    i_data,
    input   [32 - 1 : 0]    i_debug_pointer,
    output  [32 - 1 : 0]    o_debug_read,
    output  [32 - 1 : 0]    o_data
);

mask_a_byte mask(
    i_data_mask,
    o_data_masked
);

memoria_por_byte memoria(
    i_clk,
    i_reset,
    i_wr_mem,
    o_data_masked, //es una entrada, indicamos que bytes queremos
    i_direc_mem,
    i_data,
    i_debug_pointer,
    o_debug_read,
    o_data_mem
);

mascarilla mascarita(
    i_data_mask,
    o_data_mem, //toma como entrada la salida del dato buscado en memoria
    o_data_mask
);

signador signador(
    i_is_unsigned,
    i_data_mask,
    o_data_mask, //toma como entrada la salida de la mascarita
    o_data
);
endmodule