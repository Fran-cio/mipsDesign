`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2022 13:34:16
// Design Name: 
// Module Name: suod_tb
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


module suod_tb;
    parameter TICKS      = 16 ;
    parameter MOD_COUNT  = 651;
    parameter CLK_PERIOD = 20; //ns
    parameter DATA_TIME  = TICKS * MOD_COUNT * CLK_PERIOD*10;

    localparam BUS_OP_SIZE = 6;
    localparam BUS_SIZE = 8;  
    localparam TAM_DATA = 32;    
    localparam BUS_BIT_ENABLE = 3;
    localparam I_CLK = 1'b0;
    localparam I_EN = 3'b000;
    localparam I_DATA_A = 8'hFF; // 255 representado en hexa de N bits    
    localparam I_DATA_B = 8'h02; // 2 representado en hexa de N bits    
    localparam I_OPERATION = 6'h0; // operaci?n 0 representada en un hexa de M bits
    localparam OP_ADD = 6'b100000;
    localparam OP_SUB = 6'b100010;
    localparam OP_AND = 6'b100100;
    localparam OP_OR = 6'b100101;
    localparam OP_XOR = 6'b100110;
    localparam OP_SRA = 6'b000011;
    localparam OP_SRL = 6'b000010;
    localparam OP_NOR = 6'b100111;
//Inputs
    reg i_clk;
    reg i_reset;
    reg i_wr,i_rd;
    
    //Outputs
    reg[BUS_SIZE - 1 : 0] in;
    wire[BUS_SIZE - 1 : 0] out;
    
    wire    o_pc_reset,Tx_de_Pc_a_Suod, Tx_de_Soud_a_Pc,
            enable_de_sepador_a_uart, enable_de_suod_a_sepador,
            fifo_vacia_de_uart_a_suod,
            enable_write_de_suod_a_bootloader, read_enable_de_suod_a_uart;
    wire    [BUS_SIZE-1:0]  orden_de_uart_a_suod, byte_de_separador_a_uart, byte_de_suod_a_bootloader;
    wire    [TAM_DATA-1:0]  palabra_de_suod_a_separador;
    wire    [5-1:0]         o_enable_latch;
    wire     [5-1:0]        i_debug_direcc_reg,i_debug_direcc_mem;
    reg     i_is_end;

    // Verilog code for ALU
    suod suod1(
            i_clk, i_reset, i_is_end,
            orden_de_uart_a_suod,
            enable_de_suod_a_sepador,
            palabra_de_suod_a_separador,
    //Enable para los latch
            o_enable_latch,
    // Lectura en registros
            32'hF4F3F2F1,
            i_debug_direcc_reg,
    // Lectura en memoria
            32'hE4E3E2E1,
            i_debug_direcc_mem, //TODO: o_debug_direcc_mem?
    // interaccion con el pc
            32'hA4A3A2A1,
            o_pc_reset,
    // Escritura de la memoria de boot
            fifo_vacia_de_uart_a_suod,
            read_enable_de_suod_a_uart,
            enable_write_de_suod_a_bootloader,
            byte_de_suod_a_bootloader       
        );       
     
     separador_bytes separadorDeBytes(
        i_clk, i_reset,
        palabra_de_suod_a_separador,
        enable_de_suod_a_sepador,
    
        byte_de_separador_a_uart,
        enable_de_sepador_a_uart
     );
     
     uart uartSuod
      (.clk(i_clk), .reset(i_reset), .rd_uart(read_enable_de_suod_a_uart),
       .wr_uart(enable_de_sepador_a_uart), .rx(Tx_de_Pc_a_Suod), .w_data(byte_de_separador_a_uart),
       .tx_full(), .rx_empty(fifo_vacia_de_uart_a_suod),
       .r_data(orden_de_uart_a_suod), .tx(Tx_de_Suod_a_Pc)
       );  
        
     uart uartPc
      (.clk(i_clk), .reset(i_reset), .rd_uart(i_rd),
       .wr_uart(i_wr), .rx(Tx_de_Suod_a_Pc), .w_data(in),
       .tx_full(), .rx_empty(),
       .r_data(out), .tx(Tx_de_Pc_a_Suod)
       ); 
       
     
        
        
    initial begin
        i_clk = I_CLK;
        i_reset = 1;
        #DATA_TIME
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
        #DATA_TIME
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
        in = 8'b10111111; // SRA 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01010101; //  Logical xor
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00110011; //  Logical or        
        #2
        i_wr=0; 
        i_rd    =1;
        #1
        i_rd    =0; 
        #DATA_TIME
        i_wr=1;
        in = 8'b00001111; //  Logical and 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b11111111; // SRA 
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b01010101; //  Logical xor
        #2
        i_wr=0;
        i_rd    =1;
        #1
        i_rd    =0;
        #DATA_TIME
        i_wr=1;
        in = 8'b00110011; //  Logical or
        #2
        i_wr=0;  
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;
        in = 8'b00001111; //  Logical and 
        i_wr=1;
        #2
        i_wr=0;
        #DATA_TIME
        i_rd    =1;
        #1
        i_rd    =0;      
        i_wr=1;
        i_is_end = 0;
        in = "S"; // SRL
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
        #DATA_TIME
        #DATA_TIME
        i_is_end = 1;
        #DATA_TIME
        #DATA_TIME
        #DATA_TIME
        $finish;
    end
    
    always begin
        #1
        i_clk = ~i_clk;
    end
endmodule

