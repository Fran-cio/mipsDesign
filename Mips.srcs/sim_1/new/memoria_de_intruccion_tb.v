`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.12.2022 17:09:51
// Design Name: 
// Module Name: memoria_de_intruccion_tb
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


module memoria_de_intruccion_tb;
    localparam NUM_BITS = 32;
    localparam NUM_REGS  = 32;
    localparam TAM_DIREC = $clog2(NUM_REGS);
    //Inputs
    reg i_clk;
    reg i_reset;

    //Outputs
    reg [ NUM_BITS-1 : 0]   i_data;    
    reg                     i_write_enable;
    reg [ TAM_DIREC-1 : 0]  i_read_direc_intruccion;
    
    wire [ NUM_BITS-1 : 0]  o_intruccion;
    wire                    is_end;
    memoria_de_instruccion memoriaDeInstruccion(
        i_clk,
        i_reset,
        i_write_enable,
        i_data,
        i_read_direc_intruccion,
                
        o_intruccion,
        is_end
    );

    initial begin
        i_clk = 0;
        i_reset = 1;
        #2
        i_reset = 0;
        i_write_enable = 1;
        i_read_direc_intruccion = 5'b0;
        i_data = 32'h0F0F0F0F0F0F0F0F;
        #10
        i_write_enable = 0;
        i_read_direc_intruccion = 5'd1;
        #2
        i_read_direc_intruccion = 5'd2;
        #2
        i_read_direc_intruccion = 5'd3;
        #2
        i_read_direc_intruccion = 5'd4;
        #2
        i_read_direc_intruccion = 5'd5;
        i_reset = 1;
        #2
        i_reset = 0;
        #2
        $finish;
    end
    
    always begin
        #1
        i_clk = ~i_clk;
    end
endmodule
