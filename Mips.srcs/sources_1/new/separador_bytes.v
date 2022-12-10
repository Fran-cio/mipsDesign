`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2022 10:52:48
// Design Name: 
// Module Name: separador_bytes
// <-----------------------------------------------
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

module separador_bytes#(
     parameter TAM_DATA  = 32
   )
   (
    input                           i_clk, i_reset,
    input   [TAM_DATA-1:0]          i_palabra_data_enviada,
    input                           i_enable_enviada_data,
    
    output  [BITS_X_BYTE-1:0]       o_byte_data_enviada,
    output                          o_write_fifo_enable
   );
   localparam BYTES_X_PALABRA = 4;
   localparam BITS_X_BYTE = 8;
    
   reg                              write_fifo_enable_reg, write_fifo_enable_next;

   reg  [BITS_X_BYTE-1:0]           byte_data_enviada_reg, byte_data_enviada_next;
   reg  [BITS_X_BYTE-1:0]           bytes_de_palabras;
   reg  [$clog2(BYTES_X_PALABRA)-1:0] contador_de_bytes_reg, contador_de_bytes_next;
   // body
   always @(posedge i_clk)
      if (i_reset)
         begin
            contador_de_bytes_reg   <=  0;
            write_fifo_enable_reg   <=  0;
            byte_data_enviada_reg   <=  0;
         end
      else
         begin
            contador_de_bytes_reg       <=  contador_de_bytes_next;
            write_fifo_enable_reg       <=  write_fifo_enable_next;
            byte_data_enviada_reg       <=  byte_data_enviada_next;
         end

   always @(*)
   begin
      contador_de_bytes_next    =   contador_de_bytes_reg;
      write_fifo_enable_next    =   write_fifo_enable_reg;  
      byte_data_enviada_next    =   byte_data_enviada_reg;
      
      byte_data_enviada_next    =   i_palabra_data_enviada[(TAM_DATA-1)-BITS_X_BYTE*contador_de_bytes_reg-:BITS_X_BYTE];  
      if(contador_de_bytes_reg == 0)
          if(i_enable_enviada_data)
          begin
            write_fifo_enable_next  =   1;
            contador_de_bytes_next  =   1;      
          end
          else
            write_fifo_enable_next  =  0;
      else
      begin
        contador_de_bytes_next  =   contador_de_bytes_reg + 1;      
      end
   end
   // output
    assign o_byte_data_enviada    =   byte_data_enviada_reg;//i_palabra_data_enviada[(TAM_DATA-1)-BITS_X_BYTE*contador_de_bytes_reg-:BITS_X_BYTE];
    assign o_write_fifo_enable  =   write_fifo_enable_reg;
endmodule