`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2022 18:20:52
// Design Name: 
// Module Name: signador
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


module signador
#(
    parameter TAM_DATO  = 32
 )
 (
    input                         i_is_unsigned,
    input   [TAM_DATO-1 : 0]      i_dato,
    output  [TAM_DATO-1 : 0]      o_dato
 );

assign o_dato  =  i_is_unsigned ? i_dato : $signed (i_dato);

endmodule
