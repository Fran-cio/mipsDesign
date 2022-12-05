`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.12.2022 15:10:38
// Design Name: 
// Module Name: sing_extender
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


module sing_extender(data_in, data_out);
  input [15:0] data_in;
  output [32-1:0] data_out;

  assign data_out = (data_in[15] == 1) ? {16'b1111111111111111, data_in} : {16'b0000000000000000, data_in};
endmodule // signExtend


