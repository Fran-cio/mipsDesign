`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2022 11:05:47
// Design Name: 
// Module Name: forwarding_unit_tb
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


module forwarding_unit_tb;
    //Inputs
    reg [5 - 1 : 0]   i_rs_if_id;
    reg [5 - 1 : 0]   i_rt_if_id;
    reg [5 - 1 : 0]   i_rd_id_ex;
    reg [5 - 1 : 0]   i_rd_ex_mem;
    reg [5 - 1 : 0]   i_rd_mem_wb;
    reg             i_reg_wr_ex_mem;
    reg             i_reg_wr_id_ex;
    reg             i_reg_wr_mem_wb;
    //Outputs
    wire [2-1 : 0] o_forward_a;
    wire [2-1 : 0] o_forward_b;

   forwarding_unit fu1(
        .i_rs_if_id(i_rs_if_id),
        .i_rt_if_id(i_rt_if_id),
        .i_rd_id_ex(i_rd_id_ex),
        .i_rd_ex_mem(i_rd_ex_mem),
        .i_rd_mem_wb(i_rd_mem_wb),
        .i_reg_wr_ex_mem(i_reg_wr_ex_mem),
        .i_reg_wr_id_ex(i_reg_wr_id_ex),
        .i_reg_wr_mem_wb(i_reg_wr_mem_wb),
        .o_forward_a(o_forward_a),
        .o_forward_b(o_forward_b)
    );

    initial begin
        i_reg_wr_ex_mem = 1'b1;
        i_reg_wr_id_ex  = 1'b1;
        i_reg_wr_mem_wb = 1'b1;
        i_rs_if_id = 5'b00010;
        i_rd_ex_mem = 5'b00010;
        i_rt_if_id = 5'b10000;
        i_rd_mem_wb = 5'b10000;
        i_rd_id_ex = 5'b10000;
        #2
        $finish;
    end
endmodule