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
    parameter DATA_TIME  = TICKS * MOD_COUNT * CLK_PERIOD;

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
   
    integer i;

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
        in = "B"; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00100000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000100; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00011011;        
        #2
        i_wr=0; 
        i_rd    =1;
        #1
        i_rd    =0; 
        #DATA_TIME
        i_wr=1;
        in = 8'b11010011;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        // ADDI 4,0,7123
        #DATA_TIME
        i_wr=1;
        in = 8'b00100000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000011;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; 
        #2
        i_wr=0; 
        i_rd    =1;
        #1
        i_rd    =0;
         #DATA_TIME
        i_wr=1;
        in = 8'b01010101;        
        #2
        i_wr=0; 
        i_rd    =1;
        #1
        i_rd    =0;
        // ADDI 3,0,85         
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b10000011; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00101000;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00100001; 
        #2
        i_wr=0;
        //ADDU  4,3,5    
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b10000011; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00110000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00100011; 
        #2
        i_wr=0;
        //subu  4,3,6  
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b10000011;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00111000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00100100; 
        #2
        i_wr=0;
        //and  4,3,7
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b10000011; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01000000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00100101;    
        #2
        i_wr=0;
        //or  4,3,8 
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b10000011; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01001000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00100110;    
        #2
        i_wr=0;
        //xor  4,3,9
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b10000011; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01010000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00100111;    
        #2
        i_wr=0;
        //nor  4,3,10
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01100100;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01011000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00101010;    
        #2
        i_wr=0;
        //slt  3,4,11 
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00001010;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01100000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b10000000;    
        #2
        i_wr=0;
        //sll  12,10,2 
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00001010;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01101000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b10000010;    
        #2
        i_wr=0;
        //srl  13,10,2 
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00001010;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01110000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b10000011;    
        #2
        i_wr=0;
        //sra  14,10,2
        #DATA_TIME
        i_wr=1;
        in = 8'b00000001;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01101010;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01111000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000100;    
        #2
        i_wr=0;
        //sllv  15,10,11
        #DATA_TIME
        i_wr=1;
        in = 8'b00000001;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01101010;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b10000000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000110;    
        #2
        i_wr=0;
        //srlv  16,10,11
        #DATA_TIME
        i_wr=1;
        in = 8'b00000001;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01101010;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b10001000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000111;    
        #2
        i_wr=0;
        //srlv  17,10,11
        #DATA_TIME
        i_wr=1;
        in = 8'b10100000;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00010001;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000100;    
        #2
        i_wr=0;
        //SH  17,8(0)
        #DATA_TIME
        i_wr=1;
        in = 8'b10100100;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00001101;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00001000;    
        #2
        i_wr=0;
        //SB  13,4(0)
        #DATA_TIME
        i_wr=1;
        in = 8'b10100000;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00001101;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000100;    
        #2
        i_wr=0;
        //SH  13,8(0)
        #DATA_TIME
        i_wr=1;
        in = 8'b10101100;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00001101;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00001100;    
        #2
        i_wr=0;
        //SW  13,12(0)
        #DATA_TIME
        i_wr=1;
        in = 8'b10000000;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00010010;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00001100;    
        #2
        i_wr=0;
        //LB  18,12(0)
        #DATA_TIME
        i_wr=1;
        in = 8'b00110010; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01010011; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00011000;        
        #2
        i_wr=0; 
        i_rd    =1;
        #1
        i_rd    =0; 
        #DATA_TIME
        i_wr=1;
        in = 8'b01010110;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        // ANDI 18,19,6230
        #DATA_TIME
        i_wr=1;
        in = 8'b10000100;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00010100;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00001100;    
        #2
        i_wr=0;
        //LH  20,12(0)
        #DATA_TIME
        i_wr=1;
        in = 8'b00110110; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b10010101; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00011000;        
        #2
        i_wr=0; 
        i_rd    =1;
        #1
        i_rd    =0; 
        #DATA_TIME
        i_wr=1;
        in = 8'b01010110;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        // ORI 21,20,6230
        #DATA_TIME
        i_wr=1;
        in = 8'b10001100;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00010110;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00001100;    
        #2
        i_wr=0;
        //LW  22,12(0)
        #DATA_TIME
        i_wr=1;
        in = 8'b00111010; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b11010111; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00011000;        
        #2
        i_wr=0; 
        i_rd    =1;
        #1
        i_rd    =0; 
        #DATA_TIME
        i_wr=1;
        in = 8'b01010110;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        // XORI 23,22,6230
        #DATA_TIME
        i_wr=1;
        in = 8'b10011100;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00011000;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00001100;    
        #2
        i_wr=0;
        //LWU  24,12(0)
        #DATA_TIME
        i_wr=1;
        in = 8'b00111100; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00011001; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00011000;        
        #2
        i_wr=0; 
        i_rd    =1;
        #1
        i_rd    =0; 
        #DATA_TIME
        i_wr=1;
        in = 8'b01010110;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        // LUI 25,24,6230
        #DATA_TIME
        i_wr=1;
        in = 8'b10010000;  
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00011010;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00000000; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00001100;    
        #2
        i_wr=0;
//        LBU  26,12(0)
        #DATA_TIME
        i_wr=1;
        in = 8'b00101011; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01011011; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01011000;        
        #2
        i_wr=0; 
        i_rd    =1;
        #1
        i_rd    =0; 
        #DATA_TIME
        i_wr=1;
        in = 8'b01010110;
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        // SLTI 25,24,6230
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        in = 8'b11111111;    
        i_wr=1;
        #2
        i_wr=0;
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        in = 8'b0;   
        i_wr=1;
        #2
        i_wr=0;
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        in = 8'b0; 
        i_wr=1;
        #2
        i_wr=0;
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        in = 8'b0; 
        i_wr=1;
        #2
        i_wr=0;
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        i_wr=1;
        in = "G"; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        for (i = 0 ; i < 32 ; i = i + 1)
        begin
            i_wr=1;        
            in = "R";
            #2
            i_wr=0;
            #DATA_TIME
            i_wr=1;
            in="T";
            #2
            i_wr=0;
            #DATA_TIME
            #DATA_TIME
            #DATA_TIME
            #DATA_TIME;
        end
        for (i = 0 ; i < 4 ; i = i + 1)
        begin
            i_wr=1;
            in = "M";
            #2
            i_wr=0;
            #DATA_TIME
            i_wr=1;
            in=",";
            #2
            i_wr=0;
            #DATA_TIME
            #DATA_TIME
            #DATA_TIME
            #DATA_TIME;
        end
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        i_wr=1;
        in = "P"; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        i_wr=1;
        in = "C"; 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        i_wr=1;
        in = "F"; 
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
