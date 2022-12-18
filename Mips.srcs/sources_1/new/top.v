`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2022 11:54:34
// Design Name: 
// Module Name: top
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


module top#(
        parameter   TAM_BYTE        =   8,
        parameter   BUS_BIT_ENABLE  =   2,
        parameter   TAM_DATA        =   32,
        parameter   TAM_CAMPO_JUMP  =   26,
        parameter   TAM_CAMPO_OP    =   5,
        parameter   TAM_DIREC_REG   =   5,
        parameter   TAM_DIREC_MEM   =   7,              
        parameter   NUM_LATCHS      =   5,
        parameter   SIGNALS_SIZE    =   18
    )(
        input   i_clk,i_reset,
        input   i_test,
        output  o_test,
        input   i_Rx,
        output  o_Tx,
        output  o_programa_cargado,
        output  o_programa_no_cargado,
        output  o_programa_terminado,        
        output  [TAM_DATA - 1 : 0]  o_leds  

    );
    
    wire    [TAM_DATA - 1 : 0]      debug_read_reg_de_mips_a_suod,
                                    debug_read_mem_de_mips_a_suod,
                                    debug_read_pc_de_mips_a_suod;
                                    
    wire    [TAM_DIREC_REG - 1 : 0] debug_direcc_reg_de_suod_a_mips;
    wire    [TAM_DIREC_MEM - 1 : 0] debug_direcc_mem_de_suod_a_mips;
                                    
    wire    [TAM_BYTE - 1 : 0]      byte_de_suod_a_bootloader;
    wire    [NUM_LATCHS - 1 : 0]    enable_latch_de_suod_a_mips;
    
    wire    [TAM_BYTE - 1 : 0]      byte_de_separador_a_uart;
    wire    [TAM_DATA - 1 : 0]      palabra_de_suod_a_separador;
    wire    [TAM_BYTE - 1 : 0]      orden_de_uart_a_suod;
    
    mips MIPS(
        i_clk,
        i_reset,
        enable_write_de_suod_a_bootloader,
        pc_reset_de_mips_a_suod,
        borrar_programa_de_mips_a_suod,
        enable_latch_de_suod_a_mips,
        byte_de_suod_a_bootloader,
        debug_direcc_mem_de_suod_a_mips,
        debug_direcc_reg_de_suod_a_mips,
        
        is_end_de_mips_a_suod,
        debug_read_reg_de_mips_a_suod,
        debug_read_mem_de_mips_a_suod,
        debug_read_pc_de_mips_a_suod
        
    );
    
    // Verilog code for ALU
    suod suod1(
            i_clk, i_reset, is_end_de_mips_a_suod,
            orden_de_uart_a_suod,
            enable_de_suod_a_sepador,
            palabra_de_suod_a_separador,
    //Enable para los latch
            enable_latch_de_suod_a_mips,
    // Lectura en registros
            debug_read_reg_de_mips_a_suod,
            debug_direcc_reg_de_suod_a_mips,
    // Lectura en memoria
            debug_read_mem_de_mips_a_suod,
            debug_direcc_mem_de_suod_a_mips, //TODO: o_debug_direcc_mem_de_suod_a_mips?
    // interaccion con el pc
            debug_read_pc_de_mips_a_suod,
            pc_reset_de_mips_a_suod,
            borrar_programa_de_mips_a_suod,
    // Escritura de la memoria de boot
            fifo_vacia_de_uart_a_suod,
            read_enable_de_suod_a_uart,
            enable_write_de_suod_a_bootloader,
            byte_de_suod_a_bootloader,
            o_programa_cargado,
            o_programa_no_cargado,
            o_leds     
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
       .wr_uart(enable_de_sepador_a_uart), .rx(i_Rx), .w_data(byte_de_separador_a_uart),
       .tx_full(), .rx_empty(fifo_vacia_de_uart_a_suod),
       .r_data(orden_de_uart_a_suod), .tx(o_Tx)
       );  
    assign  o_test                  =   i_test;
    assign  o_programa_terminado    =   is_end_de_mips_a_suod;

endmodule
