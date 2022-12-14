`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2022 12:50:07
// Design Name: 
// Module Name: top_tb
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


module top_tb;
    parameter TICKS      = 16;
    parameter MOD_COUNT  = 651;
    parameter CLK_PERIOD = 20; //ns
    parameter DATA_TIME  = TICKS * MOD_COUNT * CLK_PERIOD*2;

    localparam BUS_OP_SIZE = 6;
    localparam BUS_SIZE = 8;  
    localparam TAM_DATA = 32;    
    localparam BUS_BIT_ENABLE = 3;
    localparam I_CLK = 1'b0;


//Inputs
    reg i_clk;
    reg i_reset;
    reg i_test;
    reg i_wr,i_rd;
    
    //Outputs
    reg[BUS_SIZE - 1 : 0] in;
    wire[BUS_SIZE - 1 : 0] out;
   

    top fpga(
        i_clk,i_reset,
        i_test,
        o_test,
        Tx_de_Pc_a_fpga,
        Tx_de_fpga_a_Pc,
        o_programa_cargado
    );
        
     uart uartPc
      (.clk(i_clk), .reset(i_reset), .rd_uart(i_rd),
       .wr_uart(i_wr), .rx(Tx_de_fpga_a_Pc), .w_data(in),
       .tx_full(), .rx_empty(),
       .r_data(out), .tx(Tx_de_Pc_a_fpga)
       ); 
       
     
        
        
    initial begin
        i_clk = I_CLK;
        i_reset = 1;
        #2
        i_reset = 0;
//        i_rd    =0;
//        i_wr=1;
//        in = "P";
//        #2
//        i_wr=0;
//        i_rd    =1;
//        #1
//        i_rd    =0;
//        #DATA_TIME
//        i_wr    =1;
//        in = "C"; // 255 representado en hexa de N bits
//        #2
//        i_wr=0;
//        i_rd    =1;
//        #1
//        i_rd    =0;
//        #DATA_TIME
//        i_wr    =1;
//        in = "R"; // 255 representado en hexa de N bits
//        #2
//        i_wr=0;
//        i_rd    =1;
//        #1
//        i_rd    =0;
//        #DATA_TIME 
//        i_wr=1;   
//        in = "T";
//        #2
//        i_wr=0;
//        i_rd    =1;
//        #1
//        i_rd    =0;
//        #DATA_TIME
//        i_wr=1;
//        in = "E"; // 2 representado en hexa de N bits;
//        #2
//        i_wr=0;
//        i_rd    =1;
//        #1
//        i_rd    =0;
//        #DATA_TIME
//        i_wr=1;
//        in = "M";
//        #2
//        i_wr=0;
//        i_rd    =1;
//        #1
//        i_rd    =0;
//        #DATA_TIME
//        i_wr=1;
//        in = ","; // operaci?n 0 representada en un hexa de M bits
//        #2
//        i_wr=0;
//        i_rd    =1;
//        #1
//        i_rd    =0;
//        #DATA_TIME
//        i_wr=1;
//        in = "N"; // Addition
//        #2
//        i_wr=0;
//        i_rd    =1;
//        #1
//        i_rd    =0;
        #2
        i_rd    =0;
        i_wr=1;
        in = "B"; // Subtraction
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00100000; // SRA 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000100; //  Logical xor
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; //  Logical or        
        #2
        i_wr=0; 
        i_rd    =1;
        #1
        i_rd    =0; 
        #DATA_TIME
        i_wr=1;
        in = 8'b01010101; //  Logical and 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        // ADDI 4,0,55
        #DATA_TIME
        i_wr=1;
        in = 8'b00100000; // SRA 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000011; //  Logical xor
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; //  Logical or        
        #2
        i_wr=0; 
        i_rd    =1;
        #1
        i_rd    =0;
         #DATA_TIME
        i_wr=1;
        in = 8'b00000101; //  Logical or        
        #2
        i_wr=0; 
        i_rd    =1;
        #1
        i_rd    =0;
        // ADDI 3,0,5         
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; //  Logical and 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b10000011; // SRA 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00101000; //  Logical xor
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00100001; //  Logical or
        #2
        i_wr=0;
        //ADDU  4,3,5      
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        in = 8'b11111111; //  Logical and 
        i_wr=1;
        #2
        i_wr=0;
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        in = 8'b0; //  Logical and 
        i_wr=1;
        #2
        i_wr=0;
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        in = 8'b0; //  Logical and 
        i_wr=1;
        #2
        i_wr=0;
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        in = 8'b0; //  Logical and 
        i_wr=1;
        #2
        i_wr=0;
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        i_wr=1;
        in = "G"; // Logical nor
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME       
        $finish;
    end
    
    always begin
        #1
        i_clk = ~i_clk;
    end
endmodule
