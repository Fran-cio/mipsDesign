`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2022 17:28:37
// Design Name: 
// Module Name: mascarilla
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


module mascarilla
#(
    parameter TAM_DATO  = 32,
    parameter TAM_MASK = 2
 )
 (
    input   [TAM_MASK-1 : 0]      i_mascara,
    input   [TAM_DATO-1 : 0]      i_dato,
    output  [TAM_DATO-1 : 0]      o_dato_enmascarado
 );

assign o_dato_enmascarado[31:16]   =  i_mascara[1] ? i_dato[31:16] : 16'b0;
assign o_dato_enmascarado[15:8]    =  i_mascara[0] ? i_dato[15:8] : 8'b0;
assign o_dato_enmascarado[7:0]     =  i_dato[7:0];

endmodule
