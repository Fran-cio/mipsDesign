`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2022 10:33:49
// Design Name: 
// Module Name: memoria_por_byte
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


module memoria_por_byte#(
    parameter NUM_BITS = 32,
    parameter NUM_ENABLES = NUM_BITS / 8,
    parameter NUM_SLOTS = 32*4,
    parameter NUM_DIREC = $clog2(NUM_SLOTS)
 )
 (
    input  wire                          i_clk,
    input  wire                          i_reset,
    input  wire                          i_write_enable,
    input  wire [NUM_ENABLES - 1 : 0]    i_byte_enb,
    input  wire [NUM_DIREC - 1 : 0]      i_direcc,
    input  wire [NUM_BITS - 1 : 0]       i_data,

    input  wire [NUM_DIREC - 1 : 0]      i_direcc_debug,

    output wire [NUM_BITS - 1 : 0]       o_data_debug,

    output wire [NUM_BITS - 1 : 0]       o_data
 );

localparam BITS_EN_BYTE = 8;

reg [BITS_EN_BYTE - 1 : 0]   byte_0;
reg [BITS_EN_BYTE - 1 : 0]   byte_1;
reg [BITS_EN_BYTE - 1 : 0]   byte_2;
reg [BITS_EN_BYTE - 1 : 0]   byte_3;

reg [NUM_BITS-1 : 0] o_data_reg;
reg [NUM_BITS-1 : 0] o_data_debug_reg;

reg [BITS_EN_BYTE - 1 : 0]   memoria  [NUM_SLOTS - 1 : 0];
integer i;

always @ (posedge i_clk)
begin
    if (i_reset) 
        for (i = 0 ; i < NUM_SLOTS ; i = i + 1)
            memoria[i] <= 0;    
    else if ((i_write_enable))
        if(i_direcc != 0 && i_direcc != 1 && i_direcc != 2 && i_direcc != 3)
            begin
            memoria[i_direcc+0] <= byte_0;
            memoria[i_direcc+1] <= byte_1;
            memoria[i_direcc+2] <= byte_2;
            memoria[i_direcc+3] <= byte_3;
            end

end

always @ (negedge i_clk)
begin
    o_data_reg[0 * BITS_EN_BYTE +: BITS_EN_BYTE] 
            <= i_byte_enb[0] ? memoria[i_direcc+0]:0;
    o_data_reg[1 * BITS_EN_BYTE +: BITS_EN_BYTE] 
            <= i_byte_enb[1] ? memoria[i_direcc+1]:0;
    o_data_reg[2 * BITS_EN_BYTE +: BITS_EN_BYTE] 
            <= i_byte_enb[2] ? memoria[i_direcc+2]:0;
    o_data_reg[3 * BITS_EN_BYTE +: BITS_EN_BYTE] 
            <= i_byte_enb[3] ? memoria[i_direcc+3]:0;
                    
    o_data_debug_reg    <=  {memoria[i_direcc_debug+3],
                            memoria[i_direcc_debug+2],
                            memoria[i_direcc_debug+1],
                            memoria[i_direcc_debug+0]};
            
end

always @ (*)
begin
    if (i_byte_enb[0])
        byte_0 = i_data[0 * BITS_EN_BYTE +: BITS_EN_BYTE];
    else
        byte_0 = memoria[i_direcc+0];
end

always @ (*)
begin
    if (i_byte_enb[1])
        byte_1 = i_data[1 * BITS_EN_BYTE +: BITS_EN_BYTE];
    else 
        byte_1 = memoria[i_direcc+1];
end

always @ (*)
begin
    if (i_byte_enb[2])
        byte_2 = i_data[2 * BITS_EN_BYTE +: BITS_EN_BYTE];
    else
        byte_2 = memoria[i_direcc+2];
end
always @ (*)
begin
    if (i_byte_enb[3])
        byte_3 = i_data[3 * BITS_EN_BYTE +: BITS_EN_BYTE];
    else 
        byte_3 = memoria[i_direcc+3];
end

assign o_data = o_data_reg;
assign o_data_debug = o_data_debug_reg;

endmodule
