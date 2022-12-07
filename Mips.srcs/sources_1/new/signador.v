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
    parameter TAM_DATO  = 32,
    parameter TAM_MASK  = 2
 )
 (
    input                         i_is_unsigned,
    input   [TAM_MASK-1 : 0]      i_mascara,
    input   [TAM_DATO-1 : 0]      i_dato,
    output  [TAM_DATO-1 : 0]      o_dato
 );
    reg [TAM_DATO-1 : 0] reg_data_out;
    
    always@(*)
    begin       
        if(i_mascara == 2'b01 && (~i_is_unsigned))
            reg_data_out = (i_dato[15] == 1) ? {16'b1111111111111111, i_dato[15:0]} : {16'b0, i_dato[15:0]};
        else if(i_mascara == 2'b00 && (~i_is_unsigned))
            reg_data_out = (i_dato[7] == 1) ? {24'b111111111111111111111111, i_dato[7:0]} : {24'b0, i_dato[7:0]};
        else
            reg_data_out = i_dato;
    end

    assign o_dato  = reg_data_out;
endmodule
