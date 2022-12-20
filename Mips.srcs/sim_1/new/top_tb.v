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
    wire[TAM_DATA/2 - 1 : 0] led;

    integer i;

    top fpga(
        i_clk,i_reset,
        i_test,
        o_test,
        Tx_de_Pc_a_fpga,
        Tx_de_fpga_a_Pc,
        o_programa_cargado,
        o_programa_no_cargado,
        o_programa_terminado,
        led
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
        #2
//------------------------------- TEST OPERACIONES_ReI/LOAD/STORE --------------------            
//        enviar_byte("B");
//        enviar_intr ({8'b00100000,8'b00000100,8'b00011011,8'b11010011});                                               
//        // ADDI 4,0,7123
//        enviar_intr ({8'b00100000,8'b00000011,8'b00000000,8'b01010101});                                               
//        // ADDI 3,0,85
//        enviar_intr ({8'b00000000,8'b10000011,8'b00101000,8'b00100001});                                               
//        //ADDU  4,3,5 
//        enviar_intr ({8'b00000000,8'b10000011,8'b00110000,8'b00100011});                                               
//        //subu  4,3,6  
//        enviar_intr ({8'b00000000,8'b10000011,8'b00111000,8'b00100100});                                    
//        //and  4,3,7
//        enviar_intr ({8'b00000000,8'b10000011,8'b01000000,8'b00100101});                                    
//        //or  4,3,8 
//        enviar_intr ({8'b00000000,8'b10000011,8'b01001000,8'b00100110});                                  
//        //xor  4,3,9
//        enviar_intr ({8'b00000000,8'b10000011,8'b01010000,8'b00100111});                          
//        //nor  4,3,10
//        enviar_intr ({8'b00000000,8'b01100100,8'b01011000,8'b00101010});                          
//        //slt  3,4,11 
//        enviar_intr ({8'b00000000,8'b00001010,8'b01100000,8'b10000000});                  
//        //sll  12,10,2 
//        enviar_intr ({8'b00000000,8'b00001010,8'b01101000,8'b10000010});          
//        //srl  13,10,2 
//        enviar_intr ({8'b00000000,8'b00001010,8'b01110000,8'b10000011});  
//        //sra  14,10,2
//        enviar_intr ({8'b00000001,8'b01101010,8'b01111000,8'b00000100});  
//        //sllv  15,10,11
//        enviar_intr ({8'b00000001,8'b01101010,8'b10000000,8'b00000110});
//        //srlv  16,10,11
//        enviar_intr ({8'b00000001,8'b01101010,8'b10001000,8'b00000111});
//        //srav  17,10,11
//        enviar_intr ({8'b10100100,8'b00001101,8'b00000000,8'b00001000});                     
//        //SB  13,4(0)
//        enviar_intr ({8'b10100000,8'b00001101,8'b00000000,8'b00000100});                     
//        //SH  13,8(0)
//        enviar_intr ({8'b10101100,8'b00001101,8'b00000000,8'b00001100});             
//        //SW  13,12(0)
//        enviar_intr ({8'b10000000,8'b00010010,8'b00000000,8'b00001100});             
//        //LB  18,12(0)
//        enviar_intr ({8'b00110010,8'b01010011,8'b00011000,8'b01010110});     
//        // ANDI 18,19,6230
//        enviar_intr ({8'b10000100,8'b00010100,8'b00000000,8'b00001100});     
//        //LH  20,12(0)
//        enviar_intr ({8'b00110110,8'b10010101,8'b00011000,8'b01010110});     
//        // ORI 21,20,6230
//        enviar_intr ({8'b10001100,8'b00010110,8'b00000000,8'b00001100});     
//        //LW  22,12(0)
//        enviar_intr ({8'b00111010,8'b11010111,8'b00011000,8'b01010110});     
//        // XORI 23,22,6230
//        enviar_intr ({8'b10011100,8'b00011000,8'b00000000,8'b00001100});     
//        //LWU  24,12(0)
//        enviar_intr ({8'b00111100,8'b00011001,8'b00011000,8'b01010110});     
//        // LUI 25,24,6230
//        enviar_intr ({8'b10010000,8'b00011010,8'b00000000,8'b00001100});     
//        //  LBU  26,12(0)
//        enviar_intr ({8'b00101011,8'b01011011,8'b01011000,8'b01010110});     
//        // SLTI 25,24,22614
//        enviar_intr ({8'b11111111,8'b0,8'b0,8'b0});
////        HALT
//        for (i = 0 ; i < 70 ; i = i + 1)
//        begin
//            enviar_byte("S");
//            #DATA_TIME
//            #DATA_TIME;
//        end
////        enviar_byte("G");
//        #200
//        i_rd    =1;
//        for (i = 0 ; i < 32 ; i = i + 1)
//        begin
//            enviar_byte("R");
//            enviar_byte("T");
//            #DATA_TIME
//            #DATA_TIME;
//        end
//        for (i = 0 ; i < 4 ; i = i + 1)
//        begin
//            enviar_byte("M");
//            enviar_byte(",");
//            #DATA_TIME
//            #DATA_TIME;
//        end
//        enviar_byte("P");
////        enviar_byte("C");
////        enviar_byte("F"); 
////------------------------------- TEST JUMP CONDICIONALES Y NO --------------------    
        enviar_byte("B"); 
        enviar_intr ({8'b00001000,8'b0,8'b0,8'd5});//0
        //J 5
        enviar_intr ({8'b00100000,8'b00000011,16'd85});//1                                            
       // ADDI 3,0,85
        enviar_intr ({32'b0});//2
        //NOP
        enviar_intr ({32'b0});//3
        //NOP    
        enviar_intr ({32'b0});//4
        //NOP
        enviar_intr ({8'b00001100,24'd8});//5
        //JAL 20
        enviar_intr ({8'b00100000,8'b00000100,16'd95});//6                                             
        // ADDI 4,0,95
        enviar_intr ({32'b0});//7
        //NOP
        enviar_intr ({11'b00100000000,5'd5,16'd14}); //8                                              
//        // ADDI 5,0,14
        enviar_intr ({6'b000000,5'd5,15'b0,6'b001000});//9
        //JR $t(5)
        enviar_intr ({11'b00100000000,5'd2,16'd2}); //10                                             
        // ADDI 2,0,2
        enviar_intr ({32'b0});//11
        //NOP
        enviar_intr ({32'b0});//12
        //NOP
        enviar_intr ({32'b0});//13
        //NOP
        enviar_intr ({11'b00100000000,5'd6,16'd20}); //14                                             
        // ADDI 6,0,20
        enviar_intr ({6'b000000,5'd6,5'b0,5'd30,5'b0,6'b001001});//15
        //JALR $t(6),$t(30)
        enviar_intr ({11'b00100000000,5'd1,16'd1}); //16                                             
        // ADDI 1,0,1
        enviar_intr ({32'b0});//17
        //NOP
        enviar_intr ({32'b0});//18
        //NOP
        enviar_intr ({32'b0});//19
        //NOP
        enviar_intr ({11'b00100000000,5'd7,16'd15}); //20                                           
//        // ADDI 7,0,15
        enviar_intr ({11'b00100000000,5'd8,16'd8}); //20  
//        // ADDI 8,0,8
        enviar_intr ({6'b001000,5'd8,5'd8,16'b1}); 
        // ADDI 8,8,1
        enviar_intr ({6'b101011,5'd8,5'd7,16'b0}); 
        //Sw    8,7,0
        enviar_intr ({6'b000101,5'd8,5'd7,16'hFFFD}); 
        // BNE 8,7,-2
        enviar_intr ({6'b000100,5'd8,5'd7,16'd2}); 
        // BEQ 8,7,2
        enviar_intr ({11'b00100000000,5'd9,16'd2}); //20  
        // ADDI 9,0,8
        enviar_intr ({11'b00100000000,5'd10,16'd8}); //20  
        // ADDI 10,0,8
        enviar_intr ({11'b00100000000,5'd11,16'd8}); //20  
        // ADDI 11,0,8
        enviar_intr ({8'b01000000,24'b0});//21
        //HALT
//        for (i = 0 ; i < 10 ; i = i + 1)
//        begin
//            enviar_byte("S");
//            #DATA_TIME
//            #DATA_TIME;
//        end
        enviar_byte("G");

        enviar_byte("R");
        enviar_byte("T");
        enviar_byte("M");
        enviar_byte(",");

        enviar_byte("P");
        i_rd=1;
        #DATA_TIME
        #DATA_TIME
        #DATA_TIME
        #DATA_TIME

        $finish;
    end
    
    always begin
        #1
        i_clk = ~i_clk;
    end
    
    task enviar_intr (input [31:0] inst);  
        begin  
            enviar_byte(inst[31:24]);  
            enviar_byte(inst[23:16]);  
            enviar_byte(inst[15:8]);  
            enviar_byte(inst[7:0]);  
        end  
    endtask  

    task enviar_byte (input [7:0] inst);  
        begin              
            i_wr=1;
            in = inst; 
            #2
            i_wr=0;
            #DATA_TIME;  
        end  
    endtask
endmodule

  