`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.12.2022 19:52:47
// Design Name: 
// Module Name: write_back
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


module write_back#(
        parameter TAM_DATA = 32,
        parameter TAM_DIREC_REG =   5       
    )(
    //datos
    input   [TAM_DATA - 1 : 0]      i_dato_de_mem,
    input   [TAM_DATA - 1 : 0]      i_dato_de_reg,
    //direcciones
    input   [TAM_DIREC_REG - 1 : 0] i_direc_reg, 
    //seniales de control
    input                           i_j_return_dest,
    input                           i_mem_to_reg,
    
    output  [TAM_DATA - 1 : 0]      o_dato,
    output  [TAM_DIREC_REG - 1 : 0] o_direccion
    );
    
    mux #(
        .BITS_ENABLES(1),
        .BUS_SIZE(TAM_DATA)
    )mux_de_mem_o_reg(
        i_mem_to_reg,
        {i_dato_de_reg,i_dato_de_mem},
        o_dato
    ); 
    
     mux #(
        .BITS_ENABLES(1),
        .BUS_SIZE(TAM_DIREC_REG)
    )mux_de_direc_o_gprx(
        i_j_return_dest,
        {5'd31,i_direc_reg},
        o_direccion
    );
       
endmodule
