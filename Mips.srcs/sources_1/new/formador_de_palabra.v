`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.12.2022 18:30:30
// Design Name: 
// Module Name: formador_de_palabra
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


module formador_de_palabra#(
     parameter TAM_ORDEN = 8,  
               TAM_DATA  = 32
   )
   (
    input                       i_clk, i_reset,
    input   [TAM_ORDEN-1:0]     i_orden,
    input                       i_write_byte,
    
    output  [TAM_DATA-1:0]      o_palabra_enviada,
    output                      o_palabra_lista,
    output                      o_is_halt
   );
   localparam BYTES_X_PALABRA = 4;
    
    
   reg                              palabra_lista_reg, palabra_lista_next;

   reg  [TAM_ORDEN-1:0]             bytes_de_palabras [BYTES_X_PALABRA-1:0];
   reg  [$clog2(BYTES_X_PALABRA):0] contador_de_bytes_reg, contador_de_bytes_next;
   // body
   always @(posedge i_clk)
      if (i_reset)
         begin
            contador_de_bytes_reg   <=  0;
            palabra_lista_reg       <=  0;
         end
      else
         begin
            contador_de_bytes_reg   <=  contador_de_bytes_next;
            palabra_lista_reg       <=  palabra_lista_next;
         end

   // FSMD next-state logic
   always @(*)
   begin
      contador_de_bytes_next    =   contador_de_bytes_reg;
      palabra_lista_next        =   palabra_lista_reg;  
        
      if(i_write_byte)
      begin
        bytes_de_palabras[contador_de_bytes_reg] = i_orden;
        palabra_lista_next  =  contador_de_bytes_reg ==  BYTES_X_PALABRA-1 ? 1 : 0;
        contador_de_bytes_next  = contador_de_bytes_reg + 1;
      end
   end
   // output
    assign o_palabra_enviada    =   {bytes_de_palabras[3],bytes_de_palabras[2],bytes_de_palabras[1],bytes_de_palabras[0]};
    assign o_palabra_lista      =   palabra_lista_reg;
    assign o_is_halt            =   o_palabra_enviada[30] == 1;
endmodule
