`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2022 11:05:47
// Design Name: 
// Module Name: hazard_unit_tb
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

module hazard_unit_tb;
    //Inputs
    reg             i_jmp_brch;
    reg             i_brch;
    reg             i_mem_read_id_ex;
    reg [6-1 : 0]   i_rs_if_id;
    reg [6-1 : 0]   i_rt_if_id;
    reg [6-1 : 0]   i_rt_id_ex;
    //Output
    wire            o_latch_en;
    wire            o_is_risky;

    hazard_unit hz_unit(
        .i_jmp_brch(i_jmp_brch),
        .i_brch(i_brch),
        .i_mem_read_id_ex(i_mem_read_id_ex),
        .i_rs_if_id(i_rs_if_id),
        .i_rt_if_id(i_rt_if_id),
        .i_rt_id_ex(i_rt_id_ex),
        .o_latch_en(o_latch_en),
        .o_is_risky(o_is_risky)
    );

    initial begin
        i_jmp_brch = 1'b1;
        i_brch = 1'b0;
        i_mem_read_id_ex = 1'b1;
        i_rs_if_id = 6'b000100;
        i_rt_if_id = 6'b100000;
        i_rt_id_ex = 6'b0000100;

        #50

        i_jmp_brch = 1'b0;
        i_brch = 1'b0;
        i_mem_read_id_ex = 1'b1;
        i_rs_if_id = 6'b000100;
        i_rt_if_id = 6'b100000;
        i_rt_id_ex = 6'b0000100;

        #50

        i_jmp_brch = 1'b1;
        i_brch = 1'b1;
        i_mem_read_id_ex = 1'b1;
        i_rs_if_id = 6'b000000;
        i_rt_if_id = 6'b100100;
        i_rt_id_ex = 6'b0000100;

        #50

        i_jmp_brch = 1'b1;
        i_brch = 1'b1;
        i_mem_read_id_ex = 1'b1;
        i_rs_if_id = 6'b000000;
        i_rt_if_id = 6'b100000;
        i_rt_id_ex = 6'b0000100;

        #50

        i_jmp_brch = 1'b1;
        i_brch = 1'b1;
        i_mem_read_id_ex = 1'b1;
        i_rs_if_id = 6'b000100;
        i_rt_if_id = 6'b100000;
        i_rt_id_ex = 6'b0000100;
        
        #50
        
        i_jmp_brch = 1'b1;
        i_brch = 1'b1;
        i_mem_read_id_ex = 1'b0;
        i_rs_if_id = 6'b000100;
        i_rt_if_id = 6'b100000;
        i_rt_id_ex = 6'b0000100;
    end
endmodule