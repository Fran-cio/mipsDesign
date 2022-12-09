`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2022 10:52:48
// Design Name: 
// Module Name: separador_bytes
// <-----------------------------------------------
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

module separador_bytes(
    input       [32 - 1 : 0]    i_data,
    input                       i_rx_done,
    output      [8 - 1 : 0]     o_byte
);
localparam integer BYTE = 8;
localparam [2 - 1 : 0]
      byte_st  = 2'b00,
      byte_nd = 2'b01,
      byte_rd  = 2'b10,
      byte_th  = 2'b11;

reg [2 - 1 : 0] counter = byte_st;
reg [8 - 1 : 0] byte_data;

always @(*) 
begin
    if(i_rx_done == 1)
        case (counter)
        byte_st:
            begin
                byte_data = i_data[BYTE - 1 : 0];
                counter = byte_nd;
            end
        byte_nd:
            begin
                byte_data = i_data[2 * BYTE - 1 : BYTE];
                counter = byte_rd;
            end
        byte_rd:
            begin
                byte_data = i_data[3 * BYTE - 1 : 2 * BYTE];
                counter = byte_th;
            end
        byte_th:
            begin
                byte_data = i_data[4 * BYTE - 1 : 3 * BYTE];
                counter = byte_st;
            end
        endcase
end

assign o_byte = byte_data;
endmodule