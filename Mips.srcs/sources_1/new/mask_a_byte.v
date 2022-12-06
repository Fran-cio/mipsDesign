`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2022 10:52:48
// Design Name: 
// Module Name: mask_a_byte
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


module mask_a_byte
#(
    parameter NUM_BYTES  = 4,
    parameter TAM_MASK = $clog2(NUM_BYTES)
 )
 (
    input   [TAM_MASK-1 : 0]      i_mascara,
    output  [NUM_BYTES-1 : 0]     o_enables
 );

assign o_enables[3:2]   =   {i_mascara[1], i_mascara[1]};
assign o_enables[1]     =   i_mascara[0];
assign o_enables[0]     =   1'b1;

endmodule
