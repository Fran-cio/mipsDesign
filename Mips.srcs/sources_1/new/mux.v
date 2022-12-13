`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.12.2022 18:18:04
// Design Name: 
// Module Name: mux
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


module mux#(
        parameter BITS_ENABLES = 2,
        parameter BUS_SIZE = 8
    )(
        input   [BITS_ENABLES - 1 : 0] i_en,
        input   [2**BITS_ENABLES*BUS_SIZE - 1 : 0] i_data,
        output  [BUS_SIZE - 1 : 0] o_data 
    );
        
    //assign o_data = i_data[(BUS_SIZE-1)+BUS_SIZE*i_en-:BUS_SIZE];      
    assign o_data = i_data>>BUS_SIZE*i_en;      


endmodule
