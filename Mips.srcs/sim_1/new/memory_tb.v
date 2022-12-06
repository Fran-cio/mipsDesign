`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2022 11:05:47
// Design Name: 
// Module Name: memory_tb
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


module memory_tb;
    localparam NUM_BITS = 32;
    localparam NUM_REGS  = 32;
    localparam TAM_DIREC = $clog2(NUM_REGS);
    //Inputs
    reg i_clk;
    reg i_reset;


    //Outputs
    reg                     i_write_enable;
    reg  [1:0]              i_mask;      
    wire [3:0]              i_byte_enb;
    reg [ TAM_DIREC-1 : 0]  i_direcc;
    reg [ NUM_BITS-1 : 0]   i_data;
    
    reg [ TAM_DIREC-1 : 0]  i_direcc_debug;
    
    wire [ NUM_BITS-1 : 0]  o_data_debug;
    
    reg [ TAM_DIREC-1 : 0]  i_read_direc_A;
    reg [ TAM_DIREC-1 : 0]  i_read_direc_B;
    
    wire [ NUM_BITS-1 : 0]  o_data;
    wire [ NUM_BITS-1 : 0]  o_data_A;
    wire [ NUM_BITS-1 : 0]  o_data_B;


    // Verilog code for ALU
    memoria_por_byte memoria(
            i_clk,
            i_reset,
            i_write_enable,
            i_byte_enb,
            i_direcc,
            i_data,
            
            i_direcc_debug,
            
            o_data_debug,
            
            o_data
        );
    register_file registro(
        i_clk,
        i_reset,
        i_write_enable,
        i_data,
        i_direcc,
        i_read_direc_A,
        i_read_direc_B,
        
        i_direcc_debug,
        o_data_debug,
        
        o_data_A,
        o_data_B
    );
    mask_a_byte transductor(
        i_mask,
        i_byte_enb
    );
        
    
    initial begin
        i_clk = 0;
        i_reset = 1;
        #2
        i_reset = 0;
        i_mask = 2'b11;
        i_direcc = 5'd1;
        i_read_direc_A = 5'd1;
        i_read_direc_B = 5'd3;
        i_direcc_debug = 5'd4;
        
        i_data=32'hFFFFFFFF;
        i_write_enable = 1'b1;
        #2
        i_direcc = 5'd1;
        #2
        i_direcc = 5'd2;
        #2
        i_direcc = 5'd3;
        #2
        i_direcc = 5'd4;
        #2
        i_direcc = 5'd5;
        i_mask = 2'b01;
        #2
        i_direcc = 5'd4;
        i_mask = 2'b00;
        i_data=32'b1;
        #2
        i_write_enable = 1'b0;
        #2
        
        $finish;
    end
    
    always begin
        #1
        i_clk = ~i_clk;
    end
endmodule
