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

module instruction_fetch #(
        parameter   TAM_DATA = 32,
        parameter   BYTE = 8
    )
    (
        input                           i_clk,
        input                           i_reset,
        input                           i_pc_reset,
        input                           i_stall,
        input   [TAM_DATA - 1 : 0]      i_new_pc,
        input                           i_bootloader_write_enable,
        input   [BYTE - 1 : 0]          i_byte_de_bootloader, //la word que nos envía la suod a través del formador de palabras
        output  [TAM_DATA - 1 : 0]      o_instruction,
        output                          o_is_end, //cuando se termina de cargar la memoria de inst
        output  [TAM_DATA - 1 : 0]      o_pc_value
);

wire    [TAM_DATA-1:0]  valor_de_pc;
latch#(
    .BUS_DATA(TAM_DATA)
)pc_unit(
    .i_clock(i_clk),
    .i_reset((i_reset || i_pc_reset)),
    .i_enable(i_stall),
    .i_data(i_new_pc),
    .o_data(valor_de_pc)
);

memoria_de_instruccion mem_inst(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_write_enable(i_bootloader_write_enable),
    .i_data(i_byte_de_bootloader),
    .i_read_direc_intruccion(valor_de_pc), //La salida del PC entra a la mem
    .o_intruccion(o_instruction),
    .is_end(o_is_end)
);

assign o_pc_value   =   valor_de_pc;

endmodule