`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.12.2022 15:37:39
// Design Name: 
// Module Name: sumador
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


module sumador#(
    parameter TAM_DATO = 32
)(
    input [TAM_DATO-1:0] i_a, i_b,
    output [TAM_DATO-1:0] o_result
);
    assign o_result = i_a + i_b;
endmodule
