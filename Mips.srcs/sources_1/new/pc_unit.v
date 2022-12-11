`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.12.2022 14:59:38
// Design Name: 
// Module Name: pc_unit
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

module pc_unit(
    input                   i_clk,
    input                   i_pc_reset,
    input   [32 - 1 : 0]    i_new_pc,
    output  [32 - 1 : 0]    o_pc_value
);

reg [32 - 1 : 0] data_pc = 0;

always @(posedge i_clk)
begin
    data_pc <= i_pc_reset ? 0 : i_new_pc;
end

assign o_pc_value = data_pc;

endmodule