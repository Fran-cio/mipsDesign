`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.12.2022 14:59:38
// Design Name: 
// Module Name: execution
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

module execution#(
    parameter TAM_FUNC = 6,
    parameter TAM_DIREC = 5,
    parameter TAM_DATA = 32

)(
    input                       i_shift_src,
    input                       i_reg_dst,
    input                       i_alu_src,
    input   [3 - 1 : 0]         i_alu_op,
    input   [TAM_DATA - 1 : 0]  i_ra_data,
    input   [TAM_DATA - 1 : 0]  i_rb_data,
    input   [TAM_DATA - 1 : 0]  i_sign_extender_data, 
    input   [TAM_DIREC - 1 : 0] i_rt_address,
    input   [TAM_DIREC - 1 : 0] i_rd_address,
    output  [TAM_DIREC - 1 : 0] o_reg_address,
    output  [TAM_DATA - 1 : 0]  o_mem_data,
    output  [TAM_DATA - 1 : 0]  o_alu_data
);
wire    [TAM_FUNC - 1 : 0]  o_alu_func;
wire    [TAM_DATA - 1 : 0]  o_mux_alu_data_a;
wire    [TAM_DATA - 1 : 0]  o_mux_alu_data_b;

    mux #(
        .BITS_ENABLES(1),
        .BUS_SIZE(5)
    )
    mux_reg (
        i_reg_dst,
        {i_rt_address,i_rd_address},
        o_reg_address
    );

    mux #(
        .BITS_ENABLES(1),
        .BUS_SIZE(32)
    )
    mux_alu (
        i_alu_src,
        {i_sign_extender_data, i_rb_data},
        o_mux_alu_data_b
    );

    mux #(
        .BITS_ENABLES(1),
        .BUS_SIZE(32)
    )
    mux_shift (
        i_shift_src,
        {{27'b0, i_sign_extender_data[10 : 6]},i_ra_data},
        o_mux_alu_data_a
    );

    alu_control alu_control(
        i_alu_op,
        i_sign_extender_data[6 - 1 : 0],
        o_alu_func
    );

    alu alu(
        o_mux_alu_data_a,
        o_mux_alu_data_b,
        o_alu_func, //entrada con la función a ejecutar
        o_alu_data,
        zero_bit
    );

    assign o_mem_data = i_rb_data;
endmodule