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

module execution(
    input                   i_shift_src,
    input                   i_reg_dst,
    input                   i_alu_src,
    input   [3 - 1 : 0]     i_alu_op,
    input   [32 - 1 : 0]    i_ra_data,
    input   [32 - 1 : 0]    i_rb_data,
    input   [32 - 1 : 0]    i_sign_extender_data, 
    input   [5 - 1 : 0]     i_rt_address,
    input   [5 - 1 : 0]     i_rd_address,
    output  [5 - 1 : 0]     o_reg_address,
    output  [32 - 1 : 0]    o_mem_data,
    output  [32 - 1 : 0]    o_alu_data
);
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
        o_mux_alu_data
    );

    mux #(
        .BITS_ENABLES(1),
        .BUS_SIZE(32)
    )
    mux_shift (
        i_shift_src,
        {{27'b0, i_sign_extender_data[10 : 6]},o_mux_alu_data},
        o_shift_data
    );

    alu_control alu_control(
        i_alu_op,
        i_sign_extender_data[6 - 1 : 0],
        o_alu_func
    );

    alu alu(
        i_ra_data,
        o_shift_data,
        o_alu_func, //entrada con la función a ejecutar
        o_alu_data,
        zero_bit
    );

    assign o_mem_data = i_rb_data;
endmodule