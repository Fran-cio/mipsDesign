`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.12.2022 20:06:31
// Design Name: 
// Module Name: instruction_decode
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


module instruction_decode#(
        parameter   TAM_DATA        =   32,
        parameter   TAM_CAMPO_JUMP  =   26,
        parameter   TAM_CAMPO_OP    =   5,
        parameter   TAM_DIREC_REG   =   5       
    )(
    input                               i_clk,
    input                               i_reset,
    //Intruccion
    input   [TAM_DATA - 1 : 0]          i_instruccion,
    // Cortocircuito
    input                               i_reg_write_id_ex,
    input                               i_reg_write_ex_mem,
    input                               i_reg_write_mem_wb,
    input   [TAM_DIREC_REG - 1 : 0]     i_direc_rd_id_ex, 
    input   [TAM_DIREC_REG - 1 : 0]     i_direc_rd_ex_mem,     
    input   [TAM_DIREC_REG - 1 : 0]     i_direc_rd_mem_wb,     
    input   [TAM_DATA - 1 : 0]          i_dato_de_id_ex, 
    input   [TAM_DATA - 1 : 0]          i_dato_de_ex_mem, 
    input   [TAM_DATA - 1 : 0]          i_dato_de_mem_wb, 
    //Al registro
    input   [TAM_DATA - 1 : 0]          i_dato_de_escritura_en_reg,
    input   [TAM_DIREC_REG - 1 : 0]     i_direc_de_escritura_en_reg,
    // Para Debug
    output  [TAM_DATA - 1 : 0]          o_dato_a_debug,
    input   [TAM_DIREC_REG - 1 : 0]     i_direc_de_lectura_de_debug,
    // Para comparar salto
    output  [TAM_DATA - 1 : 0]          o_dato_ra_para_condicion,
    output  [TAM_DATA - 1 : 0]          o_dato_rb_para_condicion,
    //Para Branch
    output  [TAM_DATA - 1 : 0]          o_dato_direc_branch,
    //Para Jump
    output  [TAM_CAMPO_JUMP - 1 : 0]    o_dato_direc_jump,
    // Para direccion de retorno
    input   [TAM_DATA - 1 : 0]          i_dato_nuevo_pc,
    //Datos
    output  [TAM_DATA - 1 : 0]          o_dato_ra,
    output  [TAM_DATA - 1 : 0]          o_dato_rb,
    output  [TAM_DATA - 1 : 0]          o_dato_inmediato,
    
    output  [TAM_DIREC_REG - 1 : 0]     o_direccion_rs,
    output  [TAM_DIREC_REG - 1 : 0]     o_direccion_rt,
    output  [TAM_DIREC_REG - 1 : 0]     o_direccion_rd,
    // A control
    output  [TAM_CAMPO_OP - 1 : 0]      o_campo_op,
    // Flags de control
    input                               i_jump_o_branch
    );
    
    mux #(
        .BITS_ENABLES(1),
        .BUS_SIZE(TAM_DATA)
    )mux_de_dato_o_pc(
        i_jump_o_branch,
        {i_dato_nuevo_pc,salida_de_forwarding_dato_a},
        o_dato_ra
    ); 
    
     mux #(
        .BITS_ENABLES(2),
        .BUS_SIZE(TAM_DATA)
    )mux_de_forward_para_dato_a(
        bits_de_forward_a,
        {i_dato_de_id_ex,i_dato_de_mem_wb ,i_dato_de_ex_mem,salida_del_ra },
        salida_de_forwarding_dato_a
    );
    
    mux #(
        .BITS_ENABLES(2),
        .BUS_SIZE(TAM_DATA)
    )mux_de_forward_para_dato_b(
        bits_de_forward_b,
        {i_dato_de_id_ex,i_dato_de_mem_wb,i_dato_de_ex_mem,salida_del_rb },
        o_dato_rb
    );
    
    forwarding_unit cortocircuito(
        i_instruccion[25:21],
        i_instruccion[20:16],
        i_direc_rd_id_ex,
        i_direc_rd_ex_mem,
        i_direc_rd_mem_wb,    
        i_reg_write_ex_mem,
        i_reg_write_id_ex,
        i_reg_write_mem_wb,
        bits_de_forward_a,
        bits_de_forward_b
    );
    register_file registros(
        i_clk,
        i_reset,
        i_reg_write_mem_wb,
        i_dato_de_escritura_en_reg,
        i_direc_de_escritura_en_reg,
        i_instruccion[25:21],
        i_instruccion[20:16],

        i_direc_de_lectura_de_debug,
        o_dato_a_debug,

        salida_del_ra,
        salida_del_rb
    );
    
    sing_extender extensor_de_signo
        (i_instruccion[15:0],
         o_dato_inmediato
    );
    
    assign  o_campo_op                  =   i_instruccion[31:26];
    assign  o_dato_direc_branch         =   o_dato_inmediato;  
    assign  o_dato_direc_jump           =   i_instruccion[25:0];
    assign  o_dato_ra_para_condicion    =   salida_de_forwarding_dato_a;  
    assign  o_dato_rb_para_condicion    =   o_dato_rb;
    assign  o_direccion_rd              =   i_instruccion[15:11]; 
    assign  o_direccion_rs              =   i_instruccion[25:21]; 
    assign  o_direccion_rt              =   i_instruccion[20:16]; 

endmodule
