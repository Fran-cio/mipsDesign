`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.12.2022 16:40:42
// Design Name: 
// Module Name: memoria_de_instruccion
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


module memoria_de_instruccion#(
    parameter NUM_BITS = 32,
    parameter TAM_DIREC = 5,
    parameter NUM_REGS  = 2**TAM_DIREC //Medio mucho para mi esta cantidad, pero bueno
 )
 (
    input  wire                      i_clk,
    input  wire                      i_reset,
    input  wire                      i_write_enable,
    input  wire [ NUM_BITS-1 : 0]    i_data,
    input  wire [TAM_DIREC-1 : 0]    i_read_direc_intruccion,

    output wire [NUM_BITS-1 : 0]     o_intruccion,
    output                           is_end
 );
 
reg [NUM_BITS - 1 : 0] mem_instrucciones [NUM_REGS - 1 : 0];

reg [TAM_DIREC-1 : 0]  reg_write_ptr, next_write_ptr, succ_write_ptr; 

reg [NUM_BITS-1 : 0] reg_intruccion;
integer i;

// La escritura funciona como una fifo, los datos entran con un puntero interno
always @(posedge i_clk)
      if (i_reset)
        reg_write_ptr <= 0;
      else
        reg_write_ptr <= next_write_ptr;

always @ (posedge i_clk)
begin
    if (i_reset) 
        for (i = 0 ; i < NUM_REGS ; i = i + 1)
            mem_instrucciones[i] <= 0;    
    else if (i_write_enable)
        mem_instrucciones[reg_write_ptr] <= i_data;
end
// La lectura es con la direccion que se le ingrese
always @ (negedge i_clk)
    reg_intruccion <= mem_instrucciones[i_read_direc_intruccion];

//Esta es la logica combinacional sacada de la fifo de la uart
always @(*)
   begin
      // successive pointer values
      succ_write_ptr = reg_write_ptr + 1;
      // default: keep old values
      next_write_ptr = reg_write_ptr;
      if(i_write_enable)
          next_write_ptr = succ_write_ptr;
   end

assign o_intruccion = reg_intruccion;

// is_end nos permite vcerificar si hay instrucciones para ejecutarse
// Ya no es necesario distinguir si es una halt o lo que sea.
assign is_end = reg_write_ptr <= i_read_direc_intruccion; 

endmodule

