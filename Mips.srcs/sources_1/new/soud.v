`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.12.2022 15:50:15
// Design Name: 
// Module Name: soud
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


module soud#(
     parameter NUM_LATCH = 4,     
               TAM_ORDEN = 8,  
               TAM_DATA  = 32,
               TAM_DIREC_REG = 5
   )
   (
    input                       i_clk, i_reset, i_is_end,
    //Comunicacion con UART
    input   [TAM_ORDEN-1:0]     i_orden,
    output                      o_enable_enviada_data,
    output  [TAM_DATA-1:0]      o_data_enviada,
    //Enable para los latch
    output  [NUM_LATCH-1 : 0]   o_enable_latch,
    // Lectura en registros
    input   [TAM_DATA-1:0]      i_debug_read_reg,
    output  [TAM_DIREC_REG-1:0] i_debug_direcc_reg,
    // Lectura en memoria
    input   [TAM_DATA-1:0]      i_debug_read_mem,
    output  [TAM_DIREC_REG-1:0] i_debug_direcc_mem,
    // interaccion con el pc
    input   [TAM_DATA-1:0]      i_read_pc,
    output                      o_pc_reset,
    // Escritura de la memoria de boot
    input                       i_is_halt,
    input                       i_fifo_empty,
    output                      o_bootload_write,
    output   [TAM_ORDEN-1:0]    o_bootload_byte
   );
    
   // symbolic state declaration
   localparam [3:0]
      idle          =   4'b0000,
      next          =   4'b0001,
      read_reg      =   4'b0010,
      inc_point_reg =   4'b0011,
      dec_point_reg =   4'b0100,
      read_mem      =   4'b0101,
      inc_point_mem =   4'b0110,
      dec_point_mem =   4'b0111,
      read_pc       =   4'b1000,
      reset_pc      =   4'b1001,
      bootloader    =   4'b1010,
      run           =   4'b1011;
      
   reg  [3:0]               state_reg, state_next;
   
   reg  [NUM_LATCH-1 : 0]   enable_latch_reg, enable_latch_next;
   
   reg                      enable_enviada_data_reg, enable_enviada_data_next;
   reg  [TAM_DATA-1:0]      data_enviada_reg, data_enviada_next;
   
   reg  [TAM_DIREC_REG-1:0] debug_direcc_reg_reg, debug_direcc_reg_next;
   
   reg  [TAM_DIREC_REG-1:0] debug_direcc_mem_reg, debug_direcc_mem_next;
   
   reg                      pc_reset_reg, pc_reset_next;

   reg                      bootload_write_reg, bootload_write_next;
   reg   [TAM_ORDEN-1:0]    bootload_byte_reg, bootload_byte_next;

   // body
   // FSMD state & data registers
   always @(posedge i_clk)
      if (i_reset)
         begin
            state_reg               <=  idle;
            enable_latch_reg        <=  0;
            enable_enviada_data_reg <=  0;
   
            data_enviada_reg        <=  0;
   
            debug_direcc_reg_reg    <=  1;
   
            debug_direcc_mem_reg    <=  1;
   
            pc_reset_reg            <=  0;

            bootload_write_reg      <=  0;
            bootload_byte_reg       <=  0;
         end
      else
         begin
            state_reg               <=  state_next;
            enable_latch_reg        <=  enable_latch_next;
            enable_enviada_data_reg <=  enable_enviada_data_next;
            data_enviada_reg        <= data_enviada_next;
   
            debug_direcc_reg_reg    <= debug_direcc_reg_next;
   
            debug_direcc_mem_reg    <= debug_direcc_mem_next;
   
            pc_reset_reg            <= pc_reset_next;

            bootload_write_reg      <= bootload_write_next;
            bootload_byte_reg       <= bootload_byte_next;
         end

   // FSMD next-state logic
   always @(*)
   begin
        state_next              =   state_reg;
        enable_latch_next       =   enable_latch_reg;
        enable_enviada_data_next=   enable_enviada_data_reg;
        data_enviada_next       =   data_enviada_reg;
        
        debug_direcc_reg_next   =   debug_direcc_reg_reg;
        
        debug_direcc_mem_next   =   debug_direcc_mem_reg;
        
        pc_reset_next           =   pc_reset_reg;
        
        bootload_write_next     =   bootload_write_reg;
        bootload_byte_next      =   bootload_byte_reg;
        
      case (state_reg)
         idle:
         begin
            enable_latch_next           =   0;
            enable_enviada_data_next    =   0;
            pc_reset_next               =   0;
            bootload_write_next         =   0;
            case(i_orden)
                "S":state_next = next;
                "T":state_next = inc_point_reg;
                "R":state_next = read_reg;
                "E":state_next = dec_point_reg;
                ",":state_next = inc_point_mem;
                "M":state_next = read_mem;
                "N":state_next = dec_point_mem;
                "C":state_next = reset_pc;
                "P":state_next = read_pc;
                "B":state_next = bootloader;
                "R":state_next = run;
            endcase
         end
         next:
         begin
            if (~i_is_end)
                enable_latch_next   =   {NUM_LATCH{1'b1}};
            state_next              =   idle; 
         end  
         read_reg:
         begin
            enable_enviada_data_next    =   1;
            data_enviada_next           =   i_debug_read_reg;
            state_next                  =   idle; 
         end
         inc_point_reg:
         begin
            debug_direcc_reg_next   =   debug_direcc_reg_reg +  1;
            state_next              =   idle; 
         end
         dec_point_reg:
         begin
            debug_direcc_reg_next   =   debug_direcc_reg_reg -  1;
            state_next              =   idle; 
         end
         read_mem:
         begin
            enable_enviada_data_next    =   1;
            data_enviada_next           =   i_debug_read_mem;
            state_next                  =   idle; 
         end
         inc_point_mem:
         begin
            debug_direcc_mem_next   =   debug_direcc_mem_reg + 1;
            state_next              = idle; 
         end
         dec_point_mem:
         begin
            debug_direcc_mem_next   =   debug_direcc_mem_reg - 1;
            state_next              = idle; 
         end
         reset_pc:
         begin
            pc_reset_next = 1;
            state_next    = idle; 
         end
         read_pc:
         begin
            enable_enviada_data_next    =   1;
            data_enviada_next           =   i_read_pc;
            state_next                  =   idle; 
         end
         bootloader:
         begin
            if(~i_is_halt)
            begin
                if(~i_fifo_empty)
                begin
                    bootload_byte_next  =   i_orden;
                    bootload_write_next =   1;
                end
                else
                    bootload_write_next =   0;
            end
            else
            begin
                    bootload_write_next =   0; 
                    state_next          =   idle;               
            end       
         end
         run:
         begin
            if (~i_is_end)
                enable_latch_next       =   {NUM_LATCH{1'b1}};
            else
                if(enable_latch_reg)
                    enable_latch_next   =   enable_latch_reg>>1;
                else
                    state_next          =   idle;               
         end   
         
      endcase
   end
   // output
    assign o_enable_enviada_data    =   enable_enviada_data_reg;
    assign o_data_enviada           =   data_enviada_reg;
    //Enable para los latch
    assign enable_latch             =   enable_latch_reg;
    // Lectura en registros
    assign i_debug_direcc_reg       =   debug_direcc_reg_reg;
    // Lectura en memoria
    assign i_debug_direcc_mem       =   debug_direcc_mem_reg;
    // interaccion con el pc
    assign o_pc_reset               =   pc_reset_reg;
    // Escritura de la memoria de boot
    assign o_bootload_write         =   bootload_write_reg;
    assign o_bootload_byte          =   bootload_byte_reg;
endmodule
